dep 'rvm' do
  requires 'installed.rvm'
end

dep 'installed.rvm' do
  if !var(:rvm_under_current_user, :ask => false) && confirm("Install rvm system-wide?", :default => 'n')
    log_error 'not supported yet :)'
  else
    requires 'installed under current user.rvm', 'setup auto-loading.rvm'
  end
end

dep 'installed under current user.rvm' do
  met? { raw_which 'rvm', login_shell('which rvm') }
  meet do
    log_shell "Installing rvm using rvm-install-head",
              %{bash -c "`curl -L http://rvm.beginrescueend.com/releases/rvm-install-head`"}
  end
  after do
    log_shell "Loading rvm environment to current session", "source ~/.rvm/scripts/rvm"
  end
end

dep 'setup auto-loading.rvm' do
  met? do
    cd('~') { grep 'rvm/scripts/rvm', '.bashrc' }
  end

  meet do
    cd '~' do
      append_to_file %{[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"}, '.bashrc'
    end
  end
end

dep 'uninstalled.rvm' do
  met? { !raw_which('rvm', login_shell('which rvm')) }
  meet { shell 'rvm implode' }

  after do
    log_block "Removing rvm files" do
      shell 'rm -rf ~/.rvm'
    end
  end
end

dep 'readline.rvm_package' do
  requires 'readline.managed'
  package 'readline'
end

dep 'ruby 1.8.7 with.rvm_ruby' do
  version '1.8.7'
end

dep 'ruby 1.9.2-head with.rvm_ruby' do
  requires_when_unmet 'bison.managed', 'autoconf'
  version '1.9.2-head'
  ask_for_default? true
end