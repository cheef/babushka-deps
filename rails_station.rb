dep 'rails-station' do
  requires 'git',
           'gitg',
           'rubygems',
           'ruby 1.8.7 with.rvm_ruby',
           'ruby 1.9.2-head with.rvm_ruby',
           'rubymine',
           'balsamiq',
           'latest meld',
           'nginx',
           'latest coffee-script'

  setup do
    set :rubymine_install_path,  '/usr/local/rubymine'
    set :rvm_under_current_user, true
  end
end