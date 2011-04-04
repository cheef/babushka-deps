dep 'readline.managed' do
  installs { via :apt, 'libreadline5-dev' }
  provides []
end