def bits
  System.bits
end

def grep_in_shell command, regexp
  shell(command).split('\n').grep(regexp)
end

class System
  def self.bits
    (shell %{uname -m} === 'x86_64') ? 64 : 32
  end

  def self.codename
    look_for /Codename:\s*(.*)/, shell('lsb_release -c') { $1 }
  end
end
