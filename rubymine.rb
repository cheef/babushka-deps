dep 'rubymine' do
  requires 'java.managed', 'configured.rubymine'
end

dep 'configured.rubymine' do
  requires 'installed.rubymine'

  set :runner, File.expand_path("~/rubymine.sh")
  set :instructions,
    %{export JDK_HOME=/usr/lib/jvm/java-6-sun;
      bash #{var :rubymine_path}/bin/rubymine.sh &}

  met? { File.exists? var(:runner) }

  meet {
    shell("echo '#{var :instructions}' > #{var :runner}")
    log_ok "Execution script installed to '#{var :runner}'"
  }

  after { sudo "chmod +x #{var :runner}"}

end

dep 'installed.rubymine' do
  requires 'downloaded.rubymine'
end

dep 'downloaded.rubymine' do
  define_var :version, :default => '3.1', :message => "Will be download this version"
  define_var :rubymine_path, :default => '~/rubymine', :message => "Rubymine would be installed there"

  set :filename, %{RubyMine-#{var :version}.tar.gz}

  met? { File.directory? File.expand_path(var :rubymine_path) }

  before { shell("mkdir #{var :rubymine_path}") }
  meet {
    handle_source "http://download.jetbrains.com/ruby/#{var :filename}" do |resource|
      shell("mv * #{var :rubymine_path}")
      log_ok "Rubymine installed to '#{var :rubymine_path}'"
    end
  }
end