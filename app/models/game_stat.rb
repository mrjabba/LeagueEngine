class GameStat < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  
  serialize   :stats
end
