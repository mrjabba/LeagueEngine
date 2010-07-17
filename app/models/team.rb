class Team < ActiveRecord::Base
  belongs_to :league
  has_many :league_stats
  has_many :stats, :class_name => 'TeamStat'
  has_many :games, :through => :stats
  has_many :team_members
  has_many :players, :through => :team_members
  
  after_validation :create_tag
  
  def create_tag
    self.team_tag = name[0..2]
  end
  
  def self.all_teams(account)
    teams = []
    for league in account.leagues
      for team in league.teams
        teams << team
      end
    end
    return teams
  end
  
  def clear_players_numbers
    team_members.all?{|tm| tm.number = 0}
  end
  
  def members_in_number_order
    members = []
    team_members.find(:all, :order=>"number").each do |member|
      members[member.number.to_i] = member.player.name 
    end
    return members
  end
  
  def members_in_game(game)
    members = []
    game.player_stats.all(team_members.all.collect(&:player_id))
  end
  
  def name_for_select
    return self.league.name + "-" + self.name
  end
  
  def generate_team_data
    stats = {}
    self.league.league_stat_types.each do |stat|
      stats[stat.name] = 0
    end
    LeagueList.create({:league_id => league.id, :team_id => id, :stats => stats})
    #LeagueList.create(:league_id => league.id, 
     #                 :team_id => id, 
      #                :stats => { "played"=>0, "wins"=>0, "draws"=>0, "losses"=>0, "for"=>0, "against"=>0, "difference"=>0, "points"=>0})
  end
end
