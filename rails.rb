dep 'rails.gem' do
  provides 'rails'
end

dep 'setup project on.rails' do
  requires 'create project on.rails', 'app bundled'
end

dep 'create project on.rails' do
  requires 'rails.gem', 'configured.www'

  setup do
    define_var :application,   :message => "Application name"
    define_var :rails_options, :default => '-d postgresql -TJ', :message => 'Use this options for rails'
    set        :rails_env, 'development'
  end

  def rails_root
    @rails_root ||= begin
      value = var(:www_path).p/var(:application)
      set :rails_root, value
      value
    end
  end

  met? { rails_root.exists? }
  meet do
    options = var(:rails_options)
    result  = nil

    log_block "Creating `#{var(:application)}` application" do
      result = failable_shell "rails new #{var(:application)} #{options}", :cd => var(:www_path)
      result.stdout
    end
    log_error result.stderr unless result.stderr.blank?
  end
end

dep 'rails project with nginx proxy' do
  requires 'configured.nginx',
           'setup project on.rails',
           'create proxy.nginx',
           'add host mapping.www',
           'unicorn.gem'

  setup { set :ip, "127.0.0.1" }
end