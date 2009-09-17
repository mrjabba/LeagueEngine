class DefaultData < ActiveRecord::Migration
  def self.up
    MenuItem.create(:name => 'accounts', :sub_menu => ['add','list'])
    MenuItem.create(:name => 'leagues', :sub_menu => ['add','list','print'])
    MenuItem.create(:name => 'games', :sub_menu => ['dashboard','add','browse','stats'])
    MenuItem.create(:name => 'teams', :sub_menu => ['add','list'])
    MenuItem.create(:name => 'users', :sub_menu => ['add','list'])    
    
    LeagueStat.create(:league_id => 0, :name => 'played', :tag => 'p', :order => 1)
    LeagueStat.create(:league_id => 0, :name => 'wins', :tag => 'w', :order => 2)
    LeagueStat.create(:league_id => 0, :name => 'draws', :tag => 'd', :order => 3)
    LeagueStat.create(:league_id => 0, :name => 'losses', :tag => 'l', :order => 4)
    LeagueStat.create(:league_id => 0, :name => 'for', :tag => 'f', :order => 5)
    LeagueStat.create(:league_id => 0, :name => 'against', :tag => 'a', :order => 6)
    LeagueStat.create(:league_id => 0, :name => 'difference', :tag => 'diff', :order => 7)
    LeagueStat.create(:league_id => 0, :name => 'points', :tag => 'pts', :order => 8)
    
    Sport.create(:name => 'Water Polo')
    Sport.create(:name => 'Cricket')
    Sport.create(:name => 'Netball')
    
    StatType.create(:name => 'GamePlayed', :entity =>'All')
    StatType.create(:name => 'Goals', :entity =>'Team')
  end

  def self.down
    LeagueStat.destroy_all(:league_id => 0)
    
    Sport.destroy_all
  end
end
