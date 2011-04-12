dep 'autoconf' do
  requires 'autoconf.managed'
end

dep 'autoconf.managed' do
  installs { via :apt, 'autoconf' }
  provides ['autoconf']
end