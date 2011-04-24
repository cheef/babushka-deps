dep('latest node-js') { requires 'node-js.src' }
dep 'node-js.src' do
  source 'git://github.com/joyent/node.git'
  provides 'node', 'node-waf'
  build   { log_shell "build (it may take a lot of time)", "make" }
  install { Babushka::SrcHelper.install_src! 'make install', :sudo => true }
end
