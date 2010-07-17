class League < ActiveRecord::Base
  belongs_to :account
  has_many :stats, :class_name => 'LeagueStat'
  has_many :teams
  has_many :games
  
  named_scope :default, :conditions =>{:account_id => 1, :name => 'DefaultLeague'}
  
  def self.create_default(account)
    debugger
    l = League.default.first.clone
    l.account_id = account.id
    l.save 
  end
  
  def clone
    new_league = League.new({:name => self.name, :account_id => self.account_id})
    
    stats.each do |stat|
      new_league.stats.build(stat.attributes)  
    end
    
    teams.each do |team|
      new_league.teams.build(team.attributes)  
    end
    new_league
  end
  
  def refresh_league!
    league_stats = ordered_league_stats
    league_lists.each do |ll|
      league_stats.each do |ls|
        ll.stats[ls.name] = 0
        ll.save
      end
    end
    
    games.each do |g|
      add_result(g) if g.completed?
    end
  end
end
