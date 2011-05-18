dep 'mongodb.managed' do
  provides %w(mongo mongod)
end

dep 'mongo.gem' do
  requires 'mongodb.managed'
  provides []
end