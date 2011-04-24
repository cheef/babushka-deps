dep 'nginx' do
  requires { on :ubuntu, 'nginx.ppa' }
  requires 'nginx.managed'
end

dep 'nginx.ppa' do
  adds 'ppa:nginx/stable'
end

dep 'nginx.managed'