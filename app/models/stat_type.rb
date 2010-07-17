class StatType < ActiveRecord::Base
  belongs_to :account
  has_many :league_stats
  has_many :team_stats
  has_many :player_stats
  
  
  named_scope :player, :conditions =>{:entity => 'player'}
  named_scope :player_game_played, :conditions =>{:name => 'GamePlayed', :entity => 'player'}
  named_scope :player_without_gameplayed, :conditions => "entity = 'player' AND name <> 'GamePlayed'"
  
  named_scope :team_score, :conditions =>{:name => 'score', :entity => 'team'}
  
  #def self.player_stats
  #  find(:all, :conditions => {:entity => 'player'})
  #end
  
  #def self.player_game_played
  #  find(:first, :conditions => {:name => 'GamePlayed', :entity => 'player'})
  #end

  def self.create_defaults(account)
    Account.default.first.stats.each do |stat|
      account.stats.create(stat.attributes)
    end
  end
end
