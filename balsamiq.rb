dep 'balsamiq' do
  requires { on :ubuntu, 'balsamiq.src' }
end

dep 'balsamiq.src' do
  requires_when_unmet 'adobe air'
  set :package_name, 'balsamiqmockupsfordesktop.'
  source "http://builds.balsamiq.com/b/mockups-desktop/MockupsForDesktop#{System.bits}bit.deb"
  process_source { sudo("dpkg -i MockupsForDesktop#{System.bits}bit.deb") }
  met? do
    !shell("apt-cache show #{var :package_name}").nil? && !shell("apt-cache show #{var :package_name}").split('\n').grep(/Status: install ok/).empty?
  end
end
