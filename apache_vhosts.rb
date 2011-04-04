meta :apache do
  def domain_name_with_www
    "www.#{domain_name}"
  end

  def domain_name
    var(:domain_name).strip.gsub /^www./, ''
  end

  def application_path
    var(:www_path)/domain_name
  end

  def public_path
    application_path/'public'
  end

  def logs_path
    application_path/'log'
  end
end

dep 'create virtual host under.apache' do
  requires_when_unmet 'add host mapping.www'

  setup {
    define_var :domain_name, :message => 'For what hostname'
    define_var :rails_env, :default => 'production', :message => 'for application environment'
    define_var :www_path,  :default => '/var/www', :message => 'www path should be somewhere here'
    set :virtual_hosts_path, '/etc/apache2/sites-available'
    set :host_config_path, var(:virtual_hosts_path)/var(:domain_name)
  }
  met? {
    var(:host_config_path).exists?
  }
  meet {
    render_erb "apache/virtual_host.erb", :to => var(:host_config_path), :sudo => true
  }
  after {
    log_block "Creating application path and reloading apache configuration" do
      mkdirs application_path, logs_path, :sudo => true, :parents => true
      own_directory application_path, :sudo => true, :recursive => true

      sudo "a2ensite #{domain_name}"
      sudo "/etc/init.d/apache2 reload"
    end
  }
end