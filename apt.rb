dep 'apt-show-versions.managed' do
  installs do
    via :apt, 'apt-show-versions'
  end

  provides 'apt-show-versions'
end