dep 'vpnc.managed' do
  installs { via :apt, 'vpnc', 'network-manager-vpnc', 'resolvconf' }
  provides 'vpnc'
end

dep 'cisco-decrypt.vpnc' do
  requires 'libgcrypt11-dev.managed'

  setup { set :package, 'cisco-decrypt' }
  met? { "/usr/bin/#{var :package}".p.exists? }

  before { log_shell "Downloading package", "wget http://www.joepcremers.nl/wordpress/wp-content/files/#{var :package}.c" }
  meet do
    log_block "Compiling and installing" do
      shell "gcc -Wall -o #{var :package} #{var :package}.c $(libgcrypt-config --libs --cflags)"
      shell "chmod +x #{var :package}"
      sudo "cp #{var :package} /usr/bin"
    end
  end
  after { shell "rm -rf #{var :package}" }
end

dep 'pcf2vpnc.vpnc' do
  setup { set :package, 'pcf2vpnc' }
  met? { "/usr/bin/#{var :package}".p.exists? }

  before { log_shell "Downloading package", "wget http://www.joepcremers.nl/wordpress/wp-content/files/#{var :package}" }
  meet do
    log_block "Compiling and installing" do
      sudo "chmod +x #{var :package}"
      sudo "cp #{var :package} /usr/bin"
    end
  end
  after { shell "rm -rf #{var :package}" }
end

dep "installed cisco tools.vpnc" do
  requires 'cisco-decrypt.vpnc', 'pcf2vpnc.vpnc'
end


