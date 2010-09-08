["Water Polo", "Cricket", "Netball", "Soccer", "Hockey"].each do |s|
  sport  =   Sport.find_by_name(s)
  sport ||=  Sport.create(:name => s)
end

