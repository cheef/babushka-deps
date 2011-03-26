meta :rubymine do
  def execution_script
    %Q{
      #!/bin/sh
      export JDK_HOME=/usr/lib/jvm/java-6-sun;
      bash #{var :install_path}/bin/rubymine.sh > /dev/null &
    }
  end

  def title
    'RubyMine'
  end

  def version
    '3.1'
  end

  def runner
    "~/rubymine.sh"
  end

  def default_path
    '~/rubymine'
  end

  def pattern
    "#{title}*"
  end

end

dep 'rubymine' do
  requires {
    on :linux, 'configured.rubymine'
  }
end

dep 'clear.rubymine' do
  requires 'downloaded clear.rubymine', 'build clear.rubymine'
end

dep 'downloaded clear.rubymine' do
  met? {
    in_download_dir do
      Dir[pattern].empty?
    end
  }
  meet {
    log_block "Removing downloaded packages" do
      in_download_dir do
        shell %{find . -name '#{pattern}' -exec rm -rf {} \\;}
      end
    end
  }
end

dep 'build clear.rubymine' do
  met? {
    in_build_dir do
      Dir[pattern].empty?
    end
  }
  meet {
    log_block "Removing temp folders" do
      in_build_dir do
        shell %{find . -name '#{pattern}' -exec rm -rf {} \\;}
      end
    end
  }
end

dep 'uninstall.rubymine' do
  requires 'uninstall personal data.rubymine'

  setup {
    define_var :install_path, :default => File.expand_path(default_path), :message => "#{title} installed previously to"
  }

  met? {
    !var(:install_path).p.exists? && !File.expand_path(runner).p.exists?
  }

  meet {
    log_block "Uninstall #{title}" do
      shell(%{rm -f '#{File.expand_path runner}'}) && shell(%{rm -rf '#{var :install_path}'})
    end
  }
end

dep 'uninstall personal data.rubymine' do
  setup {
    set :personal_data_pattern, "#{File.expand_path("~/")}/.#{pattern}"
  }

  met? {
    Dir[var :personal_data_pattern].empty?
  }
  meet {
    log_shell "Removing #{title} personal data", %{rm -rf #{var :personal_data_pattern}}
  }
end

dep 'configured.rubymine' do
  requires 'installed.rubymine', 'java'

  setup {
    set :runner, File.expand_path(runner)
    define_var :install_path, :default => File.expand_path(default_path), :message => "#{title} will be installed to"
  }

  met? { var(:runner).p.exists? && var(:install_path).p.exists? }

  meet {
    log_block "Creating execution script to '#{runner}'" do
      shell "echo '#{execution_script}' > '#{File.expand_path var(:runner)}'"
    end
  }

  after { sudo "chmod +x #{var :runner}"}

end

dep 'installed.rubymine' do
  requires 'downloaded.rubymine'

  met? {
    File.exists? File.expand_path(var :install_path)
  }

  meet {
    in_build_dir do
      log_shell "Copying to chosen path", %{cp -r '#{var :filename}/#{var :filename}' '#{File.expand_path var(:install_path)}'}
    end
  }
end

dep 'downloaded.rubymine' do

  setup {
    define_var :version, :default => version, :message => "Preferred version of #{title}"
    set :filename, %{RubyMine-#{var :version}}
    set :archive,  "#{var :filename}.tar.gz"
  }

  met? {
    in_download_dir { File.exists?(var :archive) } && in_build_dir { File.exists?(var :filename) }
  }

  meet { handle_source "http://download.jetbrains.com/ruby/#{var :archive}" do; end }
end
