class Firefox

  def binary_dir
    cmd_dir cmd
  end

  def lib_dir
    ( binary_dir / follow_symlink(binary_dir.p/cmd) ).directory
  end

  def cmd
    'firefox'
  end

  def extensions_dir
    lib_dir / 'extensions'
  end

  protected

    def follow_symlink linked
      shell("ls -la #{linked}").scan(/(.*) -> (.*)/).first[1]
    end

end

def firefox
  @firefox ||= Firefox.new
end