def found? looking_for, target, &block
  matches = look_for looking_for, target, &block
  matches && !matches.empty?
end

def look_for looking_for, target, &block
  looking_for = /#{Regexp.escape looking_for}/ if looking_for.is_a?(String)
  unless target.blank?
    target.split("\n").delete_if{ |s| s.empty? }.grep(looking_for, &block)
  end
end