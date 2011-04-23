dep 'latest thunderbird' do
  requires { on :ubuntu, 'thunderbird.ppa' }
  requires_when_unmet 'thunderbird.managed'
  requires 'apt-show-versions.managed'

  met? do
    grep_in_shell('apt-show-versions thunderbird', '(.*) upgradeable from (.*) to (.*)').empty?
  end

  meet {
    log_block "Updating thunderbird" do
      sudo 'apt-get update'
      sudo 'apt-get upgrade -y'
    end
  }
end

dep 'thunderbird.ppa' do
  adds 'ppa:mozillateam/thunderbird-stable'
end

dep 'thunderbird.managed' do
  installs { via :apt, 'thunderbird' }
  provides 'thunderbird'
end