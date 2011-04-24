dep('latest coffee-script') { requires 'coffee-script.src' }
dep 'coffee-script.src' do
  requires 'node-js.src'
  source 'git://github.com/jashkenas/coffee-script.git'
  provides 'coffee >= 1.0'

  configure { true }
  build     { shell "bin/cake build" }
  install   { shell "bin/cake install" }
end