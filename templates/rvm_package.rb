meta :rvm_package do

  def installed?
    cd('~/.rvm/src') { not Dir["#{package}*"].empty? }
  end

  accepts_value_for :package

  template do
    met? { installed? }
    meet { log_shell "Downloading and installing #{package} package", "rvm package install #{package}" }
  end

end