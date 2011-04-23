dep 'meld' do
  requires { on :ubuntu, 'meld.managed' }
end

dep 'meld.managed'

dep 'latest meld', :template => 'src' do
  requires_when_unmet 'intltool.managed'
  source 'http://ftp.gnome.org/pub/gnome/sources/meld/1.5/meld-1.5.1.tar.bz2'
  process_source { sudo "make prefix=/usr/local install" }
  provides 'meld'
end