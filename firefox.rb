dep 'latest firefox' do
  requires { on :ubuntu, 'firefox.ppa' }
  requires 'firefox.managed'
  #requires 'apt-show-versions'

  met? {
    shell('apt-show-versions firefox').split('\n').grep('(.*) upgradeable from (.*) to (.*)').empty?
  }

  meet {
    log_block "Updating firefox" do
      sudo 'apt-get update'
      sudo 'apt-get upgrade -y'
    end
  }
end

dep 'firefox.ppa' do
  adds 'ppa:mozillateam/firefox-stable'
end

dep 'firefox.managed' do
  installs { via :apt, 'firefox' }
  provides 'firefox'
end