meta :hh_enders_client do
  def default_path
    '~/hh-enders-client'
  end

  def application_name
    'Haven-and-Hearth-client-modified-by-Ender'
  end

  def title
    %{H&H Ender's client}
  end

  def execution_script
    %Q{
      #!/bin/sh
      java -Xms384m -Xmx384m -Djava.library.path=/usr/lib/jni -jar haven.jar moltke.seatribe.se -r ./res
    }
  end
end

dep "hh_enders_client" do
  requires { otherwise 'configured.hh_enders_client' }
end

dep "uninstall.hh_enders_client" do
  define_var :install_path, :default => default_path, :message => "There can be #{title} installed previously"

  unless var(:install_path).p.exists?
    log_error %{Mmm, #{title} can't be found at path '#{var :install_path}'}
  end

  met? { !var(:install_path).p.exists? }
  meet {
    log_shell "Removing #{title}", %{rm -rf #{var :install_path}}
  }
end

dep "clear.hh_enders_client" do
  set :build_cache_path, Babushka::BuildPrefix / application_name
  met? { !var(:build_cache_path).p.exists? }
  meet { log_shell "Removing #{title} cache", %{rm -rf '#{var :build_cache_path}'} }
end

dep "configured.hh_enders_client" do
  requires 'java', 'jogl', 'installed.hh_enders_client'

  setup {
    define_var :install_path, :default => default_path, :message => "Where would you like H&H Ender's client installed"

    set :runner_filename, 'haven'
    set :runner_path,     File.join( File.expand_path(var :install_path), var(:runner_filename) )
  }

  met? { File.exists? var(:runner_path) }
  meet {
    in_dir var(:install_path) do
      log_shell "Creating execution script", %{echo '#{execution_script}' > '#{var :runner_path}' }
    end
  }

  after { sudo %{chmod +x '#{var(:runner_path)}'} }
end

dep 'installed.hh_enders_client' do

  requires_when_unmet 'build.hh_enders_client'

  met? { File.exists? File.expand_path( var(:install_path) ) }
  meet {
    shell %{mkdir -p '#{ File.expand_path var(:install_path) }'}
    in_build_dir application_name do
      shell %{cp -r build/* '#{ File.expand_path var(:install_path) }'}
    end
  }
end

dep "build.hh_enders_client" do
  requires_when_unmet "downloaded.hh_enders_client", 'ant'

  met?  {
    in_build_dir application_name do
      File.exists? 'build'
    end
  }

  meet {
    in_build_dir application_name do
      log_block 'Building client from sources with ant' do
        shell 'ant'
      end
    end
  }
end

dep "downloaded.hh_enders_client" do
  requires 'git'

  met? {
    in_build_dir application_name do
      File.exists? '.git'
    end
  }
  meet { git "https://github.com/EnderWiggin/#{application_name}.git" }
end