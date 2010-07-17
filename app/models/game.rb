class Game < ActiveRecord::Base
  has_many :game_stats
  has_many :player_stats, :dependent => :destroy
  has_many :players, :through => :player_stats
  
  belongs_to :league
  belongs_to :team1,
             :class_name => "Team", 
             :foreign_key => "team1_id" 
  belongs_to :team2,
             :class_name => "Team", 
             :foreign_key => "team2_id"       
             
  validates_associated :player_stats
  
  attr_accessor :team1_stats, :team2_stats, :new_player_stats, :completed_before_save
  
  def game_completed=(game_completed)
    self.completed = 1 if game_completed
  end
  
  def new_player_stats=(stat_attributes)
    stat_attributes.each do |stat_att|
      player_stats.build(stat_att)
    end
  end
  
  def existing_player_stats=(stat_attributes)
    player_stats.reject(&:new_record?).each do |stat|
      attributes = stat_attributes[stat.id.to_s]   
      if attributes
        stat.attributes = attributes      
      else 
        player_stats.delete(stat)
      end
    end  
  end
  
  def date_dmy
    date.strftime('%d %B %Y')
  end
  
  def date_dmy=(date_dmy)
    self.date = Time.now if self.date.nil?
    d = DateTime.parse(date_dmy)
    self.date = DateTime.new(d.year, d.mon, d.day, date.hour, date.min, 0)
  end
  
  def time
    date.strftime("%H:%M")
  end
  
  def time=(time)
    self.date = DateTime.new if self.date.nil?
    t = DateTime.parse(time)
    self.date = DateTime.new(date.year, date.mon, date.day, t.hour, t.min, 0)
  end
  
  def before_save
    g = Game.find(id) if !id.nil?
    self.completed_before_save = g.completed if !g.nil? 
  end
  
  def after_create
    #process_team_lists
    save_game_stats
  end
  
  def after_update
    #process_team_lists
    save_game_stats
    save_player_stats
  end
  
  def completed_changed?
    completed_before_save != completed
  end
  
  def after_find
    self.team1_score = team1.score
    self.team1_score ||= 0
    
    self.team2_score = team2.score
    self.team2_score ||= 0
  end
  
  
  def self.get_games(games, params)
    for league in account.leagues
      for game in Game.all(:conditions => {:league_id => league, :completed => completed})
        games << game
      end
    end
  end 
  
  def teams=(teams)
    PlayerStat.game_played.delete_all(:game_id => self.id) #don't worry about update just delete and start again
    
    teams.each do |team_id, team|
      t = Team.find(team_id)
      t.clear_players_numbers unless team["forget_team"]
    
      team['players'].each_with_index do |player, i|
        unless player.empty?
          p = t.players.find_by_full_name(player)
          if p.nil?
            p = t.players.create(:name => player)
            t.team_members(:conditions => {:pid => p.id}).first.update_attribute(:number, i+1) unless team["forget_team"]
          end #p.nil?
          
          player_stats.build(:team_id => t.id, :player_id => p.id, 
                            :stat_type_id => StatType.player_game_played, 
                            :value => 1, :number => i+1)
        end #unless player.empty?
      end #team['players'].each_with_index do |player, i|
    end #teams.each do |team_id, team|
  end # def teams
  
  def add_result_to_league
      league.add_result(self)
  end
  
  def update_league
      league.refresh_league!
  end
  
  def score_changed?(old_game)
    return true if old_game.team1_goals != team1_goals
    return true if old_game.team2_goals != team2_goals
    return false
  end
  
  def players_in_number_order(team)
    members = []
    player_stats.game_played.each do |ps|
      members[ps.number] = ps.player.name if ps.player.team_members.exists?(:team_id => team)       
    end
    return members
  end  
end