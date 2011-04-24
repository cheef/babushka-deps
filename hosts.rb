meta :www do
  def domain_name_with_www
    add_www var(:domain)
  end

  def domain_name
    strip_www var(:domain)
  end
end

dep 'add host mapping.www' do
  setup { set :hosts_path, '/etc/hosts' }

  met? { grep domain_name, var(:hosts_path)  }
  meet do
    log_block "Adding #{var(:domain)} to #{var(:hosts_path)}" do
      append_to_file  "#{var :ip} #{domain_name} #{domain_name_with_www}",
                      var(:hosts_path), :sudo => !var(:hosts_path).p.writable?
    end
  end
end