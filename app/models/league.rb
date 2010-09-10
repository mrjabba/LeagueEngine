class League < ActiveRecord::Base
  belongs_to :account
  has_many :stats, :class_name => 'LeagueStat', :dependent => :destroy
  has_many :stat_types, :through => :stats
  has_many :teams, :dependent => :destroy
  has_many :games, :dependent => :destroy
  
  named_scope :default, :conditions =>{:account_id => 1, :name => 'DefaultLeague'}
  named_scope :latest, :order => :created_at
  
  def self.default(attributes = {})
    l = League.new({
      :name => 'DefaultLeague'
    }.with_indifferent_access.merge(attributes))
    
    # BLITZ Review: is this cool 
    %w(Australia Brazil China Denmark).each do |team|
      t = Team.new({:name => team})
      l.account.stats.league.each do |stat|
        ls = LeagueStat.new({:stat_type => stat, :value => 0}) 
        l.stats << ls
        t.league_stats << ls
      end
      l.teams << t
    end
    
    return l
  end
  
  def new_team_attributes=(attrs)
    attrs.each do |team_attrs|
      debugger
      team   = teams.first
      team ||= account.leagues.first.teams.first rescue nil
      team ||= Team.default.first
      
      new_team = team.clone(self)
      new_team.update_attribute('name', team_attrs[:name])     
    end
  end
  
  def existing_team_attributes=(attrs)
    teams.reject(&:new_record?).each do |team|
      attributes = attrs[team.id.to_s]   
      if attributes
        team.update_attributes(attributes)
      else 
        teams.delete(team)
      end
    end
  end
  
  def clone(acc = self.account)
    new_league = nil
    League.transaction do
      new_league = League.create({:name => self.name, :account_id => acc.id})
    
      teams.each do |team|
        team.clone(new_league)
      end
    end
    
    new_league
  end
end
