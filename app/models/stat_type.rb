class StatType < ActiveRecord::Base
  belongs_to :account
  has_many :league_stats
  has_many :team_stats
  has_many :player_stats
  
  named_scope :league,         :conditions => {:entity => 'LeagueStat'}
  named_scope :league_display, :conditions => 'entity = \'LeagueStat\' and display_order is not null' , :order => 'display_order' 
  named_scope :league_sorting, :conditions => 'entity = \'LeagueStat\' and sort_order is not null' , :order => 'sort_order' 
  
  
  named_scope :ordered, :group => 'name', :order => 'display_order'
  named_scope :player, :conditions =>{:entity => 'player'}
  named_scope :player_game_played, :conditions =>{:name => 'GamePlayed', :entity => 'player'}
  named_scope :player_without_gameplayed, :conditions => "entity = 'player' AND name <> 'GamePlayed'"
  
  named_scope :team_score, :conditions =>{:name => 'score', :entity => 'team'}
  
  
  def self.default_stats
    [
      StatType.new( :entity => 'LeagueStat',  :name => 'played',      :display => "Played",      :short_desc => 'P',   :display_order => 1),
      StatType.new( :entity => 'LeagueStat',  :name => 'wins',        :display => "Wins",        :short_desc => 'W',   :display_order => 2, :sort_order => 4),
      StatType.new( :entity => 'LeagueStat',  :name => 'draws',       :display => "Draws",       :short_desc => 'D',   :display_order => 3),
      StatType.new( :entity => 'LeagueStat',  :name => 'loses',       :display => "Loses",       :short_desc => 'L',   :display_order => 4),
      StatType.new( :entity => 'LeagueStat',  :name => 'for',         :display => "For",         :short_desc => 'F',   :display_order => 5, :sort_order => 3),
      StatType.new( :entity => 'LeagueStat',  :name => 'against',     :display => "Against",     :short_desc => 'A',   :display_order => 6),
      StatType.new( :entity => 'LeagueStat',  :name => 'difference',  :display => "Difference",  :short_desc => 'Diff', :display_order => 7, :sort_order => 2),
      StatType.new( :entity => 'LeagueStat',  :name => 'points',      :display => "Points",      :short_desc => 'Pts', :display_order => 8, :sort_order => 1),
      
      StatType.new( :entity => 'TeamStat',    :name => 'score',       :display => "Score",        :short_desc => 'Scr'),
      
      StatType.new( :entity => 'PlayerStat',  :name => 'game_played', :display => "Game Played", :short_desc => 'GP'),
      StatType.new( :entity => 'PlayerStat',  :name => 'goal',        :display => "Goal",        :short_desc => 'G' ),
      StatType.new( :entity => 'PlayerStat',  :name => 'goals',       :display => "Goals",        :short_desc => 'Gs'),
      StatType.new( :entity => 'PlayerStat',  :name => 'exclusion',   :display => "Exclusion",    :short_desc => 'Ex'),
      StatType.new( :entity => 'PlayerStat',  :name => 'exclusions',  :display => "Exclusions",    :short_desc => 'Exs')
    ]
  end
  
  #def self.player_stats
  #  find(:all, :conditions => {:entity => 'player'})
  #end
  
  #def self.player_game_played
  #  find(:first, :conditions => {:name => 'GamePlayed', :entity => 'player'})
  #end
end
