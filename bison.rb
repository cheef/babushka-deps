dep 'bison.managed' do
  installs { via :apt, 'bison' }
  provides ['bison']
end