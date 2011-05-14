dep 'sqlite.managed' do
  installs 'libsqlite3-dev'
  provides []
end

dep 'sqlite3.gem' do
  requires 'sqlite.managed'
  provides []
end
