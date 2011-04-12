dep 'apt-show-versions' do
  met? {
    puts shell('dpkg --help')
    shell('dpkg -s apt-show-versions').split('\n').grep(/is not installed/).empty?
  }

  meet {
    sudo 'apt-get install apt-show-versions -y'
  }
end