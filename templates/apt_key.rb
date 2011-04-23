meta :apt_key do
  accepts_value_for :url
  accepts_value_for :key_for, :default_name

  def already_has_key?
    found? key_for, sudo('apt-key list')
  end

  template do
    met? { already_has_key? }
    meet { sudo %{wget -q #{url} -O- | sudo apt-key add -} }
  end
end