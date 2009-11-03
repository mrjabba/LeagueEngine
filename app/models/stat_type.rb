class StatType < ActiveRecord::Base
  has_many :player_stats
  has_many :game_stats
  
  #named_scope :player, :conditions =>{:entity => 'Player'}
  #named_scope :player_game_played, :conditions => {:entity => 'Player', :name => 'GamePlayed' }
  
  def self.player_stats
    st = find(:first, :conditions => {:entity => 'Player'})
    st
  end
  
  def self.player_game_played
    st = find(:first, :conditions => {:name => 'GamePlayed', :entity => 'Player'})
  end
end
