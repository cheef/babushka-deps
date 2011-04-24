#dep 'existing postgres db' do
#  requires 'postgres access'
#  met? {
#    !shell("psql -l") {|shell|
#      shell.stdout.split("\n").grep(/^\s*#{var :db_name}\s+\|/)
#    }.empty?
#  }
#  meet {
#    shell "createdb -O '#{var :username}' '#{var :db_name}'"
#  }
#end

dep 'pg.gem' do
  requires 'postgres'
  provides []
end

#dep 'postgres access' do
#  requires 'postgres', 'user exists'
#  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{var :username}\b/).empty? }
#  meet { sudo "createuser -SdR #{var :username}", :as => 'postgres' }
#end


dep 'postgres.managed' do
  requires  { on :apt, 'postgres.ppa' }

  installs do
    via :apt, %w[postgresql postgresql-client libpq-dev]
    via :brew, 'postgresql'
  end

  provides 'psql ~> 9.0.0'
end

dep 'postgres.ppa' do
  adds 'ppa:pitti/postgresql'
end

dep 'postgres' do
  requires 'postgres.managed'
end