#Background steps

Given(/^User Data '(#{STRING})'$/) do | name, data_table|
  set_instance_var(name, User.new(data_table.hashes[0]))
end

Given(/^Table '(#{STRING})'$/) do | name, data_table|
  set_instance_var(name, data_table.hashes[0])
end

Given(/^Vertical Table \'(#{STRING})\'$/) do |table_name, table_to_be_transposed|
  set_instance_var(table_name, table_to_be_transposed.transpose.hashes[0])
end

Given(/^Raw Table \'(#{STRING})\'$/) do |table_name, table_to_be_transposed|
  set_instance_var(table_name, table_to_be_transposed.raw)
end