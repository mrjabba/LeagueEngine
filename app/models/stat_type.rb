class StatType < ActiveRecord::Base
  has_many :player_stats
  has_many :game_stats
  
  def self.game_played
    st = find(:first, :conditions => {:name => 'GamePlayed'})
    st.id
  end
end
