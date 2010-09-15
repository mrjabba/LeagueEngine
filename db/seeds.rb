
puts 'Creating dafault data.'

['Water Polo', 'Cricket', 'Netball', 'Soccer', 'Hockey', 'Basketball', '-Not in this list'].each do |s|
  sport  =   Sport.find_by_name(s)
  sport ||=  Sport.create(:name => s)
end

['admin', 'registrar', 'clubmen', 'turk'].each do |r|
  role  =   Role.find_by_name(r)
  role ||=  Role.create(:name => r)
end

puts 'Done'

