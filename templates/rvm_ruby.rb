meta :rvm_ruby do

  def installed?
    found? version, shell('rvm list')
  end

  def readline_includes
    "--with-readline-dir=~/.rvm/usr"
  end

  accepts_value_for :version
  accepts_value_for :with_readline?,   true
  accepts_value_for :ask_for_default?, false

  template do
    requires 'rvm'
    requires_when_unmet 'readline.rvm_package'

    met? { installed? }
    meet do
      log_shell "Installing ruby #{version} under rvm", "rvm install #{version} #{readline_includes if with_readline?}"
    end

    after do
      if ask_for_default? && confirm("Makes `#{version}` default ruby version?", :default => 'y')
        log_shell "Making ruby `#{version}` default", %{rvm use #{version}@global --default}
      end
    end
  end

end