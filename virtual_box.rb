dep 'virtual_box' do
  requires 'virtual_box.managed'
end

dep 'virtual_box.apt_repository' do
  url "http://download.virtualbox.org/virtualbox/debian"
  components "contrib", "non-free"
end

dep 'virtual_box.apt_key' do
  key_for "VirtualBox"
  url "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc"
end

dep 'virtual_box.managed' do
  requires_when_unmet 'virtual_box.apt_repository', 'virtual_box.apt_key'
  installs 'virtualbox-4.0'
  provides 'virtualbox'
end