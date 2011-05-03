dep 'cheef-brew' do

  log_block "System update" do
    sudo 'apt-get update'
    sudo 'apt-get upgrade -y'
  end

  requires 'rails-station',
           'unrar',
           'keepassx',

           'latest firefox',
           'firebug.firefox_extension',
           'fast-dial.firefox_extension',
           'firesass.firefox_extension',
           'colorzilla.firefox_extension',
           'adblock-plus.firefox_extension',
           'tab-mixin-plus.firefox_extension',
           'screengrab.firefox_extension',
           'json-view.firefox_extension',

           'gstreamer audio',
           'gstreamer video',
           'gstreamer plugins',

           'latest thunderbird',
           'adobe flash',
           'skype',
           'virtual_box',
           'dropbox from sources'
end