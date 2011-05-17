dep 'java-6-sun' do
  requires { otherwise 'java-6-sun.managed' }
end

dep 'java-6-openjdk.managed' do
  installs %w(openjdk-6-jre openjdk-6-jdk)
  provides 'java'
end

dep 'java-6-sun.managed' do
  setup do
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
  end

  installs { via :apt, %w[sun-java6-bin sun-java6-jre sun-java6-jdk] }
  provides 'java'
end

dep 'switched to java-6-sun' do
  requires 'java-6-sun'
end

dep 'switched to java-6-openjdk' do
  met? {
    p failable_shell('java -version').stderr
    found?( 'OpenJDK', failable_shell('java -version').stderr)
  }
  meet do
    if not found?('java-6-openjdk', failable_shell('update-java-alternatives -l').stdout)
      log_error "Can't switch automatically, you should do it manually"
    else
      failable_shell('update-java-alternatives -s java-6-openjdk', :sudo => true).stdout
    end
  end
end