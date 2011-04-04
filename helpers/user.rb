require 'etc'

def current_user
  Etc.getlogin
end

def current_group
  shell %{groups | sed -r 's/ .*//g'} || current_user
end