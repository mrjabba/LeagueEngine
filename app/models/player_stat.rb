class PlayerStat < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  belongs_to :stat_type
  
  named_scope :game_played, :conditions => {:stat_type_id => 1}
  named_scope :not_game_played, :conditions => "stat_type_id <> 1"
  
  attr_accessor :time, :team_id
end
