class Team < ActiveRecord::Base
  belongs_to :league
  has_many :league_stats
  has_many :stats, :class_name => 'TeamStat'
  has_many :games, :through => :stats
  has_many :team_members
  has_many :players, :through => :team_members
  
  after_validation :create_tag
  
  named_scope :default, :conditions =>{:team_id => 1}
  named_scope :ordered, lambda{|stats|
    {
    :select => "teams.*, teams.id as tid, " + stats.map{|s| "(select value from league_stats where team_id = tid and stat_type_id = #{s.id}) as #{s.short_desc}"}.join(','),
    :order => stats.map{|s| "#{s.short_desc} DESC"}.join(',')
    }
  }  
  
  def clone(other_league = nil)
    attrs = self.attributes
    attrs.merge!({:league_id => other_league.id}) if other_league
    new_team = nil
    
    Team.transaction do
      new_team = Team.create(attrs)
      
      league_stats.each do |stat|
        new_stat_attrs = stat.attributes.merge({:value => 0})
        
        if other_league
          new_stat_attrs.merge!({:league_id => other_league.id})
          
          # if this league is on a different need to update to the local league stat reference
          if league.account != other_league.account
            local_stat = league.account.stats.find_by_name(stat.stat_type.name)
            new_stat_attrs.merge!({'stat_type_id' => local_stat.id})
          end
        end
        
        ls = new_team.league_stats.create(new_stat_attrs)  
      end # league_stats.each do |stat|
    end # Team.transaction do
    new_team
  end  

  def create_tag
    self.team_tag = name[0..2]
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
