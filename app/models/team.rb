class Team < ActiveRecord::Base
  has_one :league_list
  has_many :team_members
  has_many :players, :through => :team_members
  belongs_to :league
  has_many :game_stats
  has_many :games, :through => :game_stats
  
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
  
  def destroy_team_data
    league_list.delete()
    games.delete_all()
    game_stats.delete_all()
    #team_stats.delete_all()
    players.delete_all()
    team_members.delete_all()
    Team.delete(id)
  end
end
