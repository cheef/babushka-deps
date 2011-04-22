dep 'vpnc.managed' do
  installs { via :apt, 'vpnc' }
  provides []
end
