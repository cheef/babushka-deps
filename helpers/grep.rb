def found? looking_for, target
  looking_for = /#{Regexp.escape looking_for}/ if looking_for.is_a?(String)

  unless target.blank?
    not target.split("\n").delete_if{ |s| s.empty? }.grep(looking_for).empty?
  else
    false
  end
end