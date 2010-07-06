class League < ActiveRecord::Base
  belongs_to :account
  has_many :league_lists
  has_many :league_stat_types
  has_many :teams
  has_many :games
  
  def ordered_league_stats
    ls = LeagueStatType.find(:all, 
                         :conditions => { :league_id => id },
                                          :order => '"order"')
    ls
  end
  
  def self.generate_default_league(account)
    l = League.create(:name => "League 1", :account_id => account.id)
    l.generate_league_data
  end
  
  def generate_league_data(league = nil)
    #if a league is passed in duplicted
    if(!league.nil?)
      league_stat_types.each do |ls|
        ls.league_id = id
        LeagueStatType.create{ls}
      end
    else
      s1 = LeagueStatType.create({:league_id => id,:name=>'played', :tag=>'p', :formula => "", :order=>1})
      s2 = LeagueStatType.create({:league_id => id,:name=>'wins', :tag=>'w', :formula => "", :order=>2})
      s3 = LeagueStatType.create({:league_id => id,:name=>'draws', :tag=>'d', :formula => "", :order=>3})
      s4 = LeagueStatType.create({:league_id => id,:name=>'losses', :tag=>'l', :formula => "", :order=>4})
      s5 = LeagueStatType.create({:league_id => id,:name=>'for', :tag=>'f', :formula => "", :order=>5})
      s6 = LeagueStatType.create({:league_id => id,:name=>'against', :tag=>'a', :formula => "", :order=>6})
      s7 = LeagueStatType.create({:league_id => id,:name=>'difference', :tag=>'diff', :formula => "", :order=>7})
      s8 = LeagueStatType.create({:league_id => id,:name=>'points', :tag=>'pts', :formula => "", :order=>8})      
    end
    
    t1 = Team.create(:league_id => id, :name => "TeamA")
    t2 = Team.create(:league_id => id, :name => "TeamB")    
    t3 = Team.create(:league_id => id, :name => "TeamC")
    t4 = Team.create(:league_id => id, :name => "TeamD")

    t1.generate_team_data()
    t2.generate_team_data()
    t3.generate_team_data()
    t4.generate_team_data()
  end
  
  def add_result(game)
    league_lists.find_by_team_id(game.team1.id).add_result(game.team1_stats['goals'].to_i, game.team2_stats['goals'].to_i)
    
    league_lists.find_by_team_id(game.team2.id).add_result(game.team2_stats['goals'].to_i, game.team1_stats['goals'].to_i)
    #llt2 = LeagueList.first(:conditions => {:league_id => self.league.id, :team_id => team2.id })
    #llt2.add_result(team2_stats['goals'].to_i, team1_stats['goals'].to_i)
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
  
  def clean_delete(league)
    #deletes league all elements elements relating to this league 
    league.league_lists.delete_all
    league.league_stat_types.delete_al
    league.teams.delete_all
    league.games.delete_all
    league.delete
  end
end
