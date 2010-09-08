Then /^a league named "([^"]*)" should exist$/ do |arg1|
  League.find_by_name(arg1).should be_kind_of League
end