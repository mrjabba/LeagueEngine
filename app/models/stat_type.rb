class StatType < ActiveRecord::Base
  belongs_to :account
  has_many :player_stats
  has_many :game_stats
  
  named_scope :player, :conditions =>{:entity => 'player'}
  named_scope :player_game_played, :conditions =>{:name => 'GamePlayed', :entity => 'player'}
  named_scope :player_without_gameplayed, :conditions => "entity = 'player' AND name <> 'GamePlayed'"
  
  #def self.player_stats
  #  find(:all, :conditions => {:entity => 'player'})
  #end
  
  #def self.player_game_played
  #  find(:first, :conditions => {:name => 'GamePlayed', :entity => 'player'})
  #end
end
