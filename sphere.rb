meta :sphere do
  def repository
    "git@github.com:SphereConsultingInc"
  end

  def www
    "/var/www"
  end
end

dep 'sphere', :template => 'sphere' do
  requires 'installed app.sphere'
  requires 'app bundled'

  setup {
    define_var :application, :message => 'Application to be installed'
    define_var :www, :default => www, :message => "WWW folder locates in"

    set :install_path, ( var(:www) / var(:application).downcase )
    set :rails_root, var(:install_path)
    set :rails_env,  'development'
  }

end

dep 'installed app.sphere' do
  requires 'downloaded app.sphere'

  met? { !var(:install_path).p.exists? }

  meet {
    in_build_dir do
      shell %{cp -r '#{var :application}' '#{var :install_path}'}
    end
  }
end

dep 'clear cache app.sphere' do
  met? {
    in_build_dir { !var(:application).p.exists? }
  }

  meet {
    log_shell "Removing #{var :application} cache", %{rm -rf '#{Babushka::BuildPrefix / var(:application)}'}
  }
end

dep 'downloaded app.sphere' do
  met? {
    in_build_dir { var(:application).p.exists? }
  }

  meet {
    begin
      git %{#{repository}/#{var(:application)}.git}
    rescue Babushka::GitRepoError => e
      log_error "\n" + e.message
    end
  }
end