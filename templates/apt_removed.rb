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