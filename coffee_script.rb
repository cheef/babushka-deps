dep('latest coffee-script') { requires 'coffee-script.src' }
dep 'coffee-script.src' do
  requires 'node-js.src'
  source 'git://github.com/jashkenas/coffee-script.git'
  provides 'coffee >= 1.0'

  configure { true }
  build     { shell "bin/cake build" }
  install   { shell "bin/cake install" }
end

dep 'coffee-brew theme.src' do
  requires 'rubymine'

  source 'https://github.com/netzpirat/coffee-brew/raw/master/resources/theme/CoffeeBrew.xml'
  process_source do
    log_shell "Copying theme to rubymine folder", sheel("cp CoffeeBrew.xml #{'~/.RubyMine31/config/colors'.p/'CoffeeBrew.xml'}")
  end
  met? { false }

end