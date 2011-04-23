dep 'dropbox' do
  requires { on :ubuntu, 'nautilus-dropbox.src' }
end

dep 'nautilus-dropbox.src' do
  set :package, "nautilus-dropbox"
  set :deb,     "#{var :package}_0.6.7_i386.deb"
  source "http://linux.dropbox.com/packages/#{var :deb}"
  process_source { sudo("dpkg -i #{var :deb}") }
  provides []
  after { sudo "apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E" }
end

dep 'dropbox from sources', :template => 'src' do
  requires_when_unmet 'libnautilus-extension-dev.managed', 'python-docutils.managed'

  source "http://linux.dropbox.com/packages/nautilus-dropbox-0.6.7.tar.bz2"
  install { sudo "make install" }
  provides 'dropbox'

  after { shell "killall nautilus" }
end
