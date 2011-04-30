dep 'add os to.grub' do
  setup do
    define_var :os, :message => 'OS name that you want to add'
    define_var :disc_num, :message => 'Disk number (/dev/sdXY), Y'
  end

  met? { config_exists? }
  meet { render_erb 'grub/os_template.erb', :to => config_path, :sudo => true }
end