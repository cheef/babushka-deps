dep 'nginx' do
  requires { on :ubuntu, 'nginx.ppa' }
  requires 'nginx.managed'
end

dep 'nginx.ppa' do
  adds 'ppa:nginx/stable'
end

dep 'nginx.managed' do
  after do
    render_erb 'nginx/frontend.conf.erb', :to => nginx.config_path, :sudo => true
    nginx.restart!
  end
end

dep 'configured.nginx' do
  requires 'configured.www', 'create nginx default site'
end

dep 'create nginx default site' do
  met?  { nginx.sites.include?('default') }
  meet  { nginx.sites.create 'nginx/default-host.conf.erb', :to => 'default' }
  after { nginx.restart! }
end