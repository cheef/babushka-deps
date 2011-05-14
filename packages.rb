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

dep 'apt-show-versions.managed' do
  installs { via :apt, 'apt-show-versions' }
  provides 'apt-show-versions'
end

dep('unrar') { requires 'unrar.managed' }
dep 'unrar.managed'

dep 'xmlstarlet.managed'

dep 'gstreamer plugins' do
  requires 'gstreamer0.10-plugins-bad.managed',
           'gstreamer0.10-plugins-ugly.managed'
end

dep 'gstreamer audio' do
  requires 'gstreamer0.10-fluendo-mp3.managed'
end

dep 'gstreamer video' do
  requires 'gstreamer0.10-ffmpeg.managed'
end

dep('gstreamer0.10-plugins-bad.managed')  { provides [] }
dep('gstreamer0.10-plugins-ugly.managed') { provides [] }
dep('gstreamer0.10-ffmpeg.managed')       { provides [] }
dep('gstreamer0.10-fluendo-mp3.managed')  { provides [] }

dep 'libgcrypt11-dev.managed' do
  installs { via :apt, 'libgcrypt11-dev' }
  provides []
end

dep('libxslt1-dev.managed') { provides [] }
dep('libxml2-dev.managed')  { provides [] }

dep('terminator.managed') { provides 'terminator' }

