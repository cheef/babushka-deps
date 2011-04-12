meta :rvm do
end

dep 'rvm' do
  requires 'install.rvm'
end

dep 'install.rvm' do
  if confirm("Install rvm system-wide?", :default => 'n')
    log_error 'not supported yet :)'
  else
    requires 'user only installation.rvm'
  end
end

dep 'user only installation.rvm' do
  met? { raw_which 'rvm', login_shell('which rvm') }
  meet {
    log_shell "Installing rvm using rvm-install-head", 'bash -c "`curl http://rvm.beginrescueend.com/releases/rvm-install-head`"'
  }
end

dep 'lines to bash_profile install.rvm' do
  met? {
    in_dir '~' do
      grep 'rvm/scripts/rvm', '.bashrc'
    end
  }
  meet {
    in_dir '~' do
      append_to_file '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"', '.bashrc'
    end
  }
end

dep 'uninstall.rvm' do
  met? { !raw_which('rvm', login_shell('which rvm')) }
  meet {
    shell 'rvm implode'
  }
  after {
    log_block "Removing rvm files" do
      shell 'rm -rf ~/.rvm'
    end
  }
end

dep 'readline.rvm' do
  requires 'readline.managed'

  met? {
    in_dir '~/.rvm/src' do
      !Dir['readline*'].empty?
    end
  }

  meet { log_shell 'Downloading and installing readline package', "rvm package install readline" }
end

dep 'ruby 1.8.7 with.rvm' do
  requires 'rvm'
  requires_when_unmet 'readline.managed'

  met? { shell 'rvm list | grep 1.8.7' }
  meet {
    log_shell 'Installing ruby 1.8.7 under rvm', 'rvm install 1.8.7 --with-readline-dir=~/.rvm/usr'
  }
end

dep 'ruby 1.9.2-head with.rvm' do
  requires 'rvm'
  requires_when_unmet 'bison.managed', 'readline.managed', 'autoconf'

  met? { shell 'rvm list | grep 1.9.2-head' }
  meet do
    log_shell 'Installing ruby 1.9.2-head under rvm', 'rvm install 1.9.2-head --with-readline-dir=~/.rvm/usr'
  end
end