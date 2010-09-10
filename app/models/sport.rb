class Sport < ActiveRecord::Base
  has_many :accounts
  
  # a bit retarded at the moment but will use a bit of 
  # method_missing + sport.name jazzines to setup default stats for sports
  def stats
    StatType.DEFAULT_STATS
  end
end
