dep 'bison.managed' do
  installs do
    via :apt, 'bison'
  end

  provides 'bison'
end