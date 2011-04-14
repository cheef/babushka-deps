meta :apt_removed do
  accepts_list_for :removes

  template do

    def installed_packages
      all_packages.select { |l| l[/\binstall$/] }.map {|l|
        l.split(/\s+/, 2).first
      }
    end

    def all_packages
      shell("dpkg --get-selections").split("\n")
    end

    def to_remove
      packages.select do |pkg|
        removes.any? {|r| pkg[r] }
      end
    end

    def nothing_remove?
      to_remove.empty?
    end

    met? { nothing_remove? }
    meet do
      to_remove.each do |pkg|
        log_shell "Removing #{pkg}", "apt-get -y remove --purge '#{pkg}'", :sudo => true
      end
    end

    after do
      log_shell "Auto-removing packages", "apt-get -y autoremove", :sudo => true
    end

  end
end

meta :apt_repository do
  accepts_list_for :url
  accepts_list_for :distribution
  accepts_list_for :components

  def sources_path
    '/etc/apt/sources.list'
  end

  def deb
    "deb #{url} #{distribution.blank? ? System.codename : distribution} #{components}"
  end

  template do
    met? { grep deb, sources_path }

    meet do
      log_block "Adding `#{deb}` to sources" do
        shell %{echo "#{deb}" >> #{sources_path}}, :sudo => true
      end
    end

    after { Babushka::AptHelper.update_pkg_lists }
  end
end

meta :apt_key do
  accepts_list_for :url
  accepts_list_for :key_for

  template do
    met? { sudo %{apt-key list | grep '#{key_for}'} }
    meet { sudo %{wget -q #{url} -O- | sudo apt-key add -} }
  end
end