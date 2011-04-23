dep 'latest firefox' do
  requires { on :ubuntu, 'firefox.ppa' }
  requires_when_unmet 'firefox.managed'
  requires 'apt-show-versions.managed'

  met? do
    grep_in_shell('apt-show-versions firefox', '(.*) upgradeable from (.*) to (.*)').empty?
  end

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