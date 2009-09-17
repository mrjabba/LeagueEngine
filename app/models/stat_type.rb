class StatType < ActiveRecord::Base
  has_many :player_stats
  has_many :game_stats
end
