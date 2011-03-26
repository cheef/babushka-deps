dep 'jogl' do
  requires { otherwise 'jogl.managed' }
end

dep 'jogl.managed' do
  installs { via :apt, %w[libjogl-java libjogl-jni] }
  provides 'java'
end