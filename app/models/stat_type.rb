class StatType < ActiveRecord::Base
  has_many :player_stats
  has_many :game_stats
  
  #named_scope :player, :conditions =>{:entity => 'Player'}
  #named_scope :player_game_played, :conditions => {:entity => 'Player', :name => 'GamePlayed' }
  
  def self.player_stats
    find(:all, :conditions => {:entity => 'Player'})
  end
  
  def self.player_game_played
    find(:first, :conditions => {:name => 'GamePlayed', :entity => 'Player'})
  end
  
  def self.player_not_game_played
    find(:first, :conditions => ["entity = 'Player'", "name <> 'GamePlayed'"])
  end
end
