class TeamStat < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :stat_type 
  
  #use via game.team.score
  scope :score, :conditions =>{ :stat_type_id => StatType.team_score }
end