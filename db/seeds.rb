#LeagueStat.create(:league_id => 0, :name => 'played', :tag => 'p', :order => 1)
#LeagueStat.create(:league_id => 0, :name => 'wins', :tag => 'w', :order => 2)
#LeagueStat.create(:league_id => 0, :name => 'draws', :tag => 'd', :order => 3)
#LeagueStat.create(:league_id => 0, :name => 'losses', :tag => 'l', :order => 4)
#LeagueStat.create(:league_id => 0, :name => 'for', :tag => 'f', :order => 5)
#LeagueStat.create(:league_id => 0, :name => 'against', :tag => 'a', :order => 6)
#LeagueStat.create(:league_id => 0, :name => 'difference', :tag => 'diff', :order => 7)
#LeagueStat.create(:league_id => 0, :name => 'points', :tag => 'pts', :order => 8)

["Water Polo", "Cricket", "Netball", "Soccer", "Hockey"].each do |s|
  Sport.find_or_create_by_name(s)
end
    
StatType.create(:name => 'GamePlayed', :entity =>'All')
StatType.create(:name => 'Goals', :entity =>'Team')
