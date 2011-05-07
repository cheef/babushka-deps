dep('subversion') { requires 'subversion.managed' }

dep 'subversion.managed' do
  provides 'svn'
end