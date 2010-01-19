class PlayersController < ApplicationController
  layout :determine_layout
  before_filter :require_user
  
  def index
    @team_name = params[:team_name]
    teams = active_account.teams.all(:conditions => {:name => @team_name}, :order => "'name'")  if !@team_name.nil? #Team.all_teams(active_account()).sort_by{|team| team[:name]}
    teams = active_account.teams.all(:order => "'name'")      if @team_name.nil? 
    
    @player_lists = {}
    # {'gosford' => {'seniors' => [], 'juniors' => []}}
    teams.each do |t|
      juniors = []
      seniors = [] 
      t.players.all(:order => "'name'").each do |p|
        p.junior ? juniors << p.id : seniors << p.id 
      end
      
      if @player_lists[t.name]
        temp_j = @player_lists[t.name][:juniors]
        temp_s = @player_lists[t.name][:seniors]        
      
        #add players but remove dupilcates
        @player_lists[t.name][:juniors] = temp_j & juniors
        @player_lists[t.name][:seniors] = temp_s & seniors
      else
        @player_lists[t.name] = {:juniors => juniors, :seniors => seniors} 
      end        
    end
    
    # replace ids with acutal player objetcs 
    @player_lists.each do |t|
      t[:juniors] = Players.find(t[:juniors], :order => "'name'")
      t[:seniors] = Players.find(t[:seniors], :order => "'name'")
    end
  end
  
  def stats
    @team_name = params[:team_name]
    @stat  = StatType.find_by_name(params[:stat]) 
    @stat ||= StatType.player_game_played
    
    @teams = active_account.teams.all(:conditions => {:name => @team_name}, :order => "'name'")  if !@team_name.nil? #Team.all_teams(active_account()).sort_by{|team| team[:name]}
    @teams = active_account.teams.sort_by { |team| team[:name] }     if @team_name.nil? 
  end
  
  #def new
  #end
  
  #def create
  #end
  
  def edit
    @player = Player.find(params[:id])
  end
  
  def update
    @player = Player.find(params[:id])
    
    if @player.update_attributes(params[:player])
      redirect_to :action => :index
    else
      render edit
    end
  end
  
  def merge
    @player = Player.find(params[:id])
    @player.same_as_me = params[:same_as_me]
    
    if !@player.same_as_me.nil? && @player.same_as_me.count > 1
      @teams = []
    
      #get all teams for the merged players
      @player.same_as_me.each do |id|
        p = Player.find(id)
        p.teams.each do |t|
          @teams << t.id
        end
      end
      #removes duplicates
      @teams = @teams & @teams
    
      @player.merge!
      @notice = 'Players Merged'
    else
      @error = 'You need to choose atleast two players to do a merge.'
    end
  end
  
  def determine_layout 
    #return 'print' if params[:action] == 'stats'
    'application'  
  end
end
