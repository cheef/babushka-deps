dep 'existed.www' do
  setup { set :www_path, '/var/www' }
  met?  { var(:www_path).p.exists? }
  meet  { var(:www_path).p.mkdir }
end

dep 'configured.www' do
  requires 'existed.www'
  setup {
    set :www_group, 'www-data'
    p 'www setup caller'
  }
  met?  { var(:www_path).p.group == var(:www_group) }
  meet  { sudo "chgrp #{var(:www_group)} #{var(:www_path)}" }
end