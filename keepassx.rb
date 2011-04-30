dep 'keepassx' do
  requires { on :ubuntu, 'keepassx.ppa' }
  requires 'keepassx.managed'
end

dep 'keepassx.ppa' do
  adds 'ppa:keepassx/ppa'
end

dep 'keepassx.managed'