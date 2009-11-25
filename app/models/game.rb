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
             
             
  attr_accessor :teams, :team1_stats, :team2_stats, :new_player_stats, :completed_before_save
  
  def game_completed=(game_completed)
    self.completed = 1 if game_completed
  end
  #def new_player_stats=(player_stat_attributes)
   # player_stats_attributes.each do |stat|
    #  if stat[:stat_type_id] > 0 
     #   ps = player_stats.build(stat)
      #  ps.player_id = get_player(ps.team_id, ps.number)
      #end
    #end
  #end
  
  #def existing_player_stats=(player_stat_attributes)
   # player_stats.not_game_played.reject(&:new_record?).each do |stat|
    #  if stat[:stat_type_id] > 0
     #   attributes = player_stat_attributes[task.id.to_s]
      #  if attributes
       #   task.attributes = attributes
       # else 
        #  tasks.delete(task)
        #end
      #end
   # end
  #end
  
  def before_save
    g = Game.find(id) if !id.nil?
    self.completed_before_save = g.completed if !g.nil? 
  end
  
  def after_create
    process_team_lists
    save_game_stats
    #save_player_stats
  end
  
  def after_update
    process_team_lists
    save_game_stats
  end
  
  def completed_changed?
    completed_before_save != completed
  end
  
  def team1_goals
    return self.team1_stats['goals'] if !team1_stats.nil?
    return 0
  end
  
  def team1_goals=(g)
    self.team1_stats = {} if team1_stats.nil?
    self.team1_stats['goals'] = g
  end
  
  def team2_goals
    return self.team2_stats['goals'] if !team2_stats.nil?
    return 0
  end
  
  def team2_goals=(g)
    self.team2_stats = {} if team2_stats.nil?
    self.team2_stats['goals'] = g
  end
  
  def after_find
    t1gs = GameStat.first(:conditions => {:game_id => id, :team_id => team1.id})
    !t1gs.nil? ? self.team1_stats = t1gs.stats : self.team1_stats = {}
       
    t2gs = GameStat.first(:conditions => {:game_id => id, :team_id => team2.id})
    !t2gs.nil? ? self.team2_stats = t2gs.stats : self.team2_stats = {}
  end
  
  def save_game_stats
    t1gs = GameStat.first(:conditions => {:game_id => id, :team_id => team1.id})
    t1gs = GameStat.create(:game_id=> id, :team_id => team1.id)  if t1gs.nil?
    t1gs.stats =  team1_stats
    t1gs.save
  
    gst2_hash = {:game_id=> id, :team_id => team2.id}
    t2gs = GameStat.first(:conditions => gst2_hash)
    t2gs = GameStat.create(gst2_hash) if t2gs.nil?
    t2gs.stats =  team2_stats
    t2gs.save    
  end
  
  #def save_player_stats
   #player_stats.     
  #end
  
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
  
  def self.get_games(games, params)
    for league in account.leagues
      for game in Game.all(:conditions => {:league_id => league, :completed => completed})
        games << game
      end
    end
  end 
  
  def process_team_lists
    if !teams.nil?
      player_stats.not_game_played.delete_all
    
      teams.keys.each do |team_id|
        t = Team.find(team_id)
        t.clear_players_numbers if !teams[team_id]["forget_team"]
      
        teams[team_id]["players"].each_with_index do |player_name, i|
          if player_name != ""
            p = t.players.find_by_name(player_name)
            if p.nil?
              p = Player.create(:name => player_name)
              tm = TeamMember.create(:player_id => p.id, :team_id => t.id)
            end
            PlayerStat.create(:game_id => id, :player_id => p.id, 
                              :stat_type_id => StatType.player_game_played, 
                              :value => 1, :number => i+1)
            if !teams[team_id]["forget_team"]
              tm = t.team_members.first(:conditions=> {:player_id => p})
              tm.number = i+1
              tm.save 
            end
          end
        end
      end
    end
  end
  
  def add_result_to_league
      league.add_result(self)
  end
  
  def update_league
      league.refresh_league!
  end
  
  def score_changed(old_game)
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