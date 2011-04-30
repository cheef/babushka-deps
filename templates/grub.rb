meta :grub do

  def config_exists?
    config_path.p.exist?
  end

  def config_name
    "11_#{var(:os).downcase.gsub /(\s|\t)+/, '_'}"
  end

  def config_path
    '/etc/grub.d'.p/config_name
  end

  template do
    before do
      log_ok "Disks list: \n#{sudo "fdisk -l /dev/sda | grep /dev/sda"}"
    end

    after do
      sudo "chmod a+x #{config_path}"
      sudo "update-grub"
    end
  end
end