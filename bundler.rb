dep 'app bundled' do
  requires 'bundler.gem', 'Gemfile'

  met? { cd(var(:rails_root)) { shell 'bundle check', :log => true } }
  meet do
    cd var(:rails_root) do
      install_args = var(:rails_env) != 'production' ? '' : "--deployment --without 'development test'"
      unless shell("bundle install #{install_args}", :log => true)
        confirm("Try a `bundle update`") { shell 'bundle update', :log => true }
      end
    end
  end
end

dep 'Gemfile' do
  met? { (var(:rails_root) / 'Gemfile').exists? }
end

dep 'bundler.gem' do
  installs 'bundler >= 1.0.12'
  provides 'bundle'
end