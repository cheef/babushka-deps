dep 'libnautilus-extension-dev.managed' do
  installs { via :apt, 'libnautilus-extension-dev' }
  provides []
end

dep 'python-docutils.managed' do
  installs { via :apt, 'python-docutils' }
  provides []
end

dep 'intltool.managed' do
  provides 'intltool-merge'
end