dep 'adobe flash' do
  requires { on :ubuntu, 'adobe flash.src' }
end

dep 'adobe flash.src' do
  setup do
    set :package_name, 'adobe-flashplugin'
    set :filename,     'install_flash_player_10_linux.deb'
  end

  source "http://www.adobe.com/go/fp10_linux_deb"
  process_source { sudo("dpkg -i #{var :filename}") }
  met? do
    !shell("apt-cache show #{var :package_name}").nil? && !shell("apt-cache show #{var :package_name}").split('\n').grep(/Status: install ok/).empty?
  end
end