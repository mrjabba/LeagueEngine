class LeagueStat < ActiveRecord::Base
  belongs_to :team
  belongs_to :league
  belongs_to :stat_type
end