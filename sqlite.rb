dep 'sqlite3.managed' do
  installs 'libsqlite3-dev'
  provides []
end

dep 'sqlite3.gem' do
  requires 'sqlite3.managed'
  provides []
end
