Before do
  ["Water Polo", "Cricket", "Netball", "Soccer", "Hockey"].each do |s|
    sport  =   Factory(:sport, :name => s)
  end
  
  @default_league = Factory(:league, :name => 'DefaultLeague')
  
  (1..3).each do |i|
    Factory(:stat_type, :name => "stat#{i}", :account_id => @default_league.account.id)
  end
  
  
  (1..4).each do |i|
    team = Factory(:team, :league_id => @default_league.id)
    (1..3).each do |j|
      Factory(:league_stat, :league_id => @default_league.id, :team_id => team.id, :stat_type_id => StatType.find_by_name("stat#{j}").id)
    end
  end
end  