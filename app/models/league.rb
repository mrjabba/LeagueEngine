class League < ActiveRecord::Base
  belongs_to :account
  has_many :stats, :class_name => 'LeagueStat'
  has_many :stat_types, :through => :stats
  has_many :teams
  has_many :games
  
  named_scope :default, :conditions =>{:account_id => 1, :name => 'DefaultLeague'}
  
  def clone(acc = self.account)
    new_league = nil
    League.transaction do
      new_league = League.create({:name => self.name, :account_id => acc.id})
    
      teams.each do |team|
        new_team = new_league.teams.create(team.attributes)  
        
        team.league_stats.each do |stat|
          new_attrs = stat.attributes.merge({'league_id' => new_league.id})
          
          #only run this if new account is being created
          if acc.id != self.account.id
            new_stat = acc.stats.find_by_name(stat.stat_type.name)
            new_attrs.merge!({'stat_type_id' => new_stat.id})
          end
          
          ls = new_team.league_stats.create(new_attrs)  
        end
      end
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
