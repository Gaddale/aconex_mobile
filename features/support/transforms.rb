STRING = Transform /^([\w\s\(\)\/-]+)$/ do |string_match|
  string_match.strip
end

STRING_WITH_QUOTES = Transform /^([\w\s\(\)’'\/-]+)$/ do |string_match|
  string_match.strip
end


NUMBER = Transform /^([0-9]+)$/ do |num_match|
  num_match.to_i
end
