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

dep 'firebug.firefox_extension' do
  source 'https://addons.mozilla.org/firefox/downloads/latest/1843/addon-1843-latest.xpi'
end

dep 'fast-dial.firefox_extension' do
  source 'https://addons.mozilla.org/firefox/downloads/latest/fast-dial-5721/addon-fast-dial-5721-latest.xpi'
end

dep 'firesass.firefox_extension' do
  requires 'firebug.firefox_extension'
  source 'https://addons.mozilla.org/firefox/downloads/file/116287/firesass_for_firebug-0.0.7-fx.xpi'
end

dep 'colorzilla.firefox_extension' do
  source 'https://addons.mozilla.org/firefox/downloads/latest/271/addon-271-latest.xpi'
end

dep 'adblock-plus.firefox_extension' do
  source 'https://addons.mozilla.org/firefox/downloads/latest/1865/addon-1865-latest.xpi'
end

dep 'tab-mixin-plus.firefox_extension' do
  source 'https://addons.mozilla.org/firefox/downloads/latest/1122/addon-1122-latest.xpi'
end

dep 'screengrab.firefox_extension' do
  source 'https://addons.mozilla.org/firefox/downloads/latest/1146/addon-1146-latest.xpi'
end

dep 'json-view.firefox_extension' do
  source 'https://addons.mozilla.org/firefox/downloads/latest/10869/addon-10869-latest.xpi'
end