def own_directory directory, options = {}
   shell "chown #{'-R ' if options.delete(:recursive)} #{options[:user] || current_user}:#{options[:group] || current_group} #{directory}", options
end

def mkdir directory, options = {}
  shell "mkdir #{'-p' if options[:parents]} #{directory}", options
end

def mkdirs *args
  options = args.last.is_a?(Hash) ? args.pop : {}
  args.all? { |dir| mkdir dir, options }
end