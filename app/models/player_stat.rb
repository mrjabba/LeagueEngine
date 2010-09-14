class PlayerStat < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  belongs_to :game
  belongs_to :stat_type
  
  scope :game_played, :conditions => {:stat_type_id => StatType.player_game_played}
  scope :not_game_played, :conditions => ["stat_type_id > ?", StatType.player_game_played]
  
  attr_accessor :time
end
