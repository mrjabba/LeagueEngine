class LeagueList < ActiveRecord::Base
  belongs_to :league
  belongs_to :team

  serialize   :stats
  
  def sort_val
    points = self.stats['points'] || 0
    diff = self.stats['difference'] || 0
    wins = self.stats['wins'] || 0
    val = (points*100000)+(diff*100)+wins
    return val
  end

  def self.find_entry(league, team)
    ll = self.find(:first, :conditions => ["league_id = ? and team_id = ?", league, team])
    return ll
  end
  
  def add_result(p_for, p_against)
    self.stats["played"]+= 1
    self.stats["for"] += p_for
    self.stats["against"] += p_against
    self.stats["difference"] = self.stats["for"] - self.stats["against"]
    
    self.stats["wins"]+= 1 if p_for > p_against
    self.stats["losses"]+= 1 if p_for < p_against
    self.stats["draws"]+= 1 if p_for == p_against
    self.stats["points"]= 3 * self.stats["wins"] + self.stats["draws"]  
    self.save  
  end
end
