dep 'java.managed' do
  setup {
    unless shell "cat /etc/apt/sources.list | grep '^\s*deb.*partner'"
      sudo "cat /etc/apt/sources.list | grep deb.*partner | sed s/#// | tee -a /etc/apt/sources.list"
      sudo "apt-get update"
    end

    sudo "echo 'sun-java6-bin shared/accepted-sun-dlj-v1-1 boolean true' | debconf-set-selections"
    sudo "echo 'sun-java6-jdk shared/accepted-sun-dlj-v1-1 boolean true' | debconf-set-selections"
    sudo "echo 'sun-java6-jre shared/accepted-sun-dlj-v1-1 boolean true' | debconf-set-selections"
    sudo "echo 'sun-java6-jre sun-java6-jre/stopthread boolean true' | debconf-set-selections"
    sudo "echo 'sun-java6-jre sun-java6-jre/jcepolicy note' | debconf-set-selections"
    sudo "echo 'sun-java6-bin shared/present-sun-dlj-v1-1 note' | debconf-set-selections"
    sudo "echo 'sun-java6-jdk shared/present-sun-dlj-v1-1 note' | debconf-set-selections"
    sudo "echo 'sun-java6-jre shared/present-sun-dlj-v1-1 note' | debconf-set-selections"
  }
  installs {
    via :apt, %w[sun-java6-bin sun-java6-jre sun-java6-jdk]
  }
end