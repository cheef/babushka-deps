dep 'rubymine' do
  requires { on :linux, 'rubymine.src' }
end

dep 'rubymine.src' do
  requires 'java'
  source "http://download.jetbrains.com/ruby/RubyMine-3.1.1.tar.gz"
  provides 'mine'

  setup do
    if predefined_path = var(:rubymine_install_path, :ask => false)
      set :install_path, predefined_path
    end

    define_var :install_path, :default => '/usr/local/rubymine',
               :message => "Where would you like RubyMine installed"
    set :executable_path, '/usr/local/bin'
    set :sudo, !var(:install_path).p.writable?
  end

  process_source do
    mkdir var(:install_path), :parents => true,    :sudo => var(:sudo)
    shell %Q{chgrp admin '#{var(:install_path)}'}, :sudo => var(:sudo)
    shell %Q{chmod g+w '#{var(:install_path)}'},   :sudo => var(:sudo)
    shell "mv ./* #{var(:install_path)}",          :sudo => var(:sudo)
  end

  after do
    log_block "Linking RubyMine into #{var(:executable_path) / 'mine'}" do
      shell %Q{ln -sf "#{var(:install_path) / 'bin/rubymine.sh'}" "#{var(:executable_path) / 'mine'}"},
        :sudo => var(:sudo)
    end
  end
end

dep 'uninstall.rubymine' do
  requires 'uninstall personal data.rubymine'

  setup do
    if predefined_path = var(:rubymine_install_path, :ask => false)
      set :install_path, predefined_path
    end

    define_var :install_path, :default => '/usr/local/rubymine', :message => "RubyMine installed previously to"
    set :executable_path, '/usr/local/bin'
    set :files, [ var(:install_path), var(:executable_path).p/'mine' ]
  end

  met? do
    var(:files).all? { |file| not file.p.exists? }
  end

  meet do
    var(:files).delete_if{ |file| not file.p.exists? }.each do |file|
      log_shell "Uninstall RubyMine file '#{file.p}'", shell(%{rm -rf '#{file}'})
    end
  end
end

dep 'uninstall personal data.rubymine' do
  setup { set :personal_directories, "#{"~/".p}/.RubyMine*" }
  met? { Dir[ var(:personal_directories) ].empty? }
  meet do
    Dir[ var(:personal_directories) ].each do |directory|
      log_shell "Removing RubyMine personal data in #{directory}", %{rm -rf #{directory}}
    end
  end
end

#dep 'rubymine coffee-brew' do
#  met? { false }
#  meet do
#    handle_source 'http://plugins.intellij.net/files/org.coffebrew_9097.jar'
#  end
#end
#
#dep 'rubymine coffee-theme' do
#  met? { false }
#  meet do
#    handle_source 'https://github.com/netzpirat/coffee-brew/raw/master/resources/theme/CoffeeBrew.xml'
#  end
#end
#dep 'rubymine markdown' do
#  met? { false }
#  meet do
#    handle_source 'http://plugins.intellij.net/files/org.markdown_9533.jar'
#  end
#end
