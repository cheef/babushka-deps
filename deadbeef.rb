dep 'deadbeef' do
  requires { on :ubuntu, 'deadbeef.managed' }
end

dep 'deadbeef.ppa' do
  adds 'ppa:alexey-smirnov/deadbeef'
end

dep 'deadbeef.managed' do
  requires_when_unmet 'deadbeef.ppa'
  installs { via :apt, 'deadbeef' }
  provides 'deadbeef'
end

# Wanna this someday :)
#
# wanna 'deadbeef' do
#   via :ppa => 'alexey-smirnov/deadbeef'
# end