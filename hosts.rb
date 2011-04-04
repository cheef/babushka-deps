meta :www do
  def domain_name_with_www
    add_www var(:domain_name)
  end

  def domain_name
    strip_www var(:domain_name)
  end
end

dep 'add host mapping.www' do
  setup { set :hosts_path, '/etc/hosts' }

  met? { grep domain_name, var(:hosts_path)  }
  meet {
      append_to_file  "#{var :ip} #{domain_name} #{domain_name_with_www}",
                      var(:hosts_path), :sudo => true
  }
end