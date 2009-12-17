class PlayersController < ApplicationController
  layout :determine_layout
  before_filter :require_user
  
  def index
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
    @teams = []
    
    #get all teams for the merged players
    @player.same_as_me.each do |id|
      p = Player.find(id)
      p.teams.each do |t|
        @teams << t.id
      end
    end
    
    #removes duplicates
    @teams = @team & @teams
    
    if !@player.same_as_me.nil? && @player.same_as_me.count > 0
      @player.merge!
      flash[:notice] = 'Players Merged'
    else
      flash[:error] = 'You need to choose atleast two players to do a merge.'
    end
  end
  
  def determine_layout 
    return 'print' if params[:action] == 'stats'
    'application'  
  end
end
