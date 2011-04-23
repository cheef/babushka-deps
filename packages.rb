dep('ant') { requires 'ant.managed' }
dep 'ant.managed'

dep('autoconf') { requires 'autoconf.managed' }
dep 'autoconf.managed'

dep 'bison.managed' do
  installs { via :apt, 'bison' }
  provides 'bison'
end

dep('jogl') { requires 'jogl.managed' }
dep 'jogl.managed' do
  installs { via :apt, %w[libjogl-java libjogl-jni] }
  provides []
end

dep 'libnautilus-extension-dev.managed' do
  installs { via :apt, 'libnautilus-extension-dev' }
  provides []
end

dep 'python-docutils.managed' do
  installs { via :apt, 'python-docutils' }
  provides []
end

dep('intltool.managed') { provides 'intltool-merge' }

dep 'readline.managed' do
  installs { via :apt, 'libreadline5-dev' }
  provides []
end

dep 'vpnc.managed' do
  installs { via :apt, 'vpnc' }
  provides []
end

dep 'apt-show-versions.managed' do
  installs { via :apt, 'apt-show-versions' }
  provides 'apt-show-versions'
end