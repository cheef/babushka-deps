dep 'latest thunderbird' do
  requires { on :ubuntu, 'thunderbird.ppa' }
  requires 'update thunderbird'
end

dep 'update thunderbird' do
  requires 'apt-show-versions.managed', 'thunderbird.managed'
  met? { !found? '(.*) upgradeable from (.*) to (.*)', shell('apt-show-versions thunderbird') }
  meet do
    log_block "Updating thunderbird" do
      sudo 'apt-get update'
      sudo 'apt-get upgrade -y'
    end
  end
end

dep 'thunderbird.ppa' do
  adds 'ppa:mozillateam/thunderbird-stable'
end

dep 'thunderbird.managed' do
  installs { via :apt, 'thunderbird' }
  provides 'thunderbird'
end