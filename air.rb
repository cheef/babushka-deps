dep 'adobe air' do
  requires { on :ubuntu, 'adobe air.src' }
end

dep 'adobe air.src' do
  set :package_name, 'adobeair'
  source "http://airdownload.adobe.com/air/lin/download/2.6/#{var :package_name}.deb"
  process_source { sudo("dpkg -i #{var :package_name}.deb") }
  met? { shell("apt-cache show #{var :package_name}").split('\n').grep(/Status: install ok/) }
end
