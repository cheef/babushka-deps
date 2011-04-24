dep('latest node-js') { requires 'node-js.src' }
dep 'node-js.src' do
  source 'git://github.com/joyent/node.git'
  provides 'node', 'node-waf'
end
