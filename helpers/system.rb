def bits
  if shell %{uname -m} == 'x86_64'
    64
  else
    32
  end
end