dep 'cheef-brew' do
  log_block "System update" do
    sudo 'apt-get update'
    sudo 'apt-get upgrade -y'
  end

  requires 'rails-station',
           'deadbeef',
           'latest thunderbird',
           'virtual_box',
           'dropbox'
end