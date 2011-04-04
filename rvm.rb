meta :rvm do
end

dep 'rvm' do
  requires 'install.rvm'
end

dep 'install.rvm' do
  requires 'readline.managed'

  if confirm("Install rvm system-wide?", :default => 'n')
    requires 'system wide installation.rvm'
  else
    requires 'user only installation.rvm'
  end
end

dep 'system wide installation.rvm' do
  met? { raw_which 'rvm', login_shell('which rvm') }
  meet {
  }
end

dep 'user only installation.rvm' do
#  met? { raw_which 'rvm', login_shell('which rvm') }
  met? { false }
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
    sudo 'rm -r /etc/r'
  }
end