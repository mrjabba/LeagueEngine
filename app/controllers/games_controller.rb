class GamesController < ApplicationController
  before_filter :require_user

  def index
    @games = active_account.games
    @games.sort_by { |game| game[:date] }.reverse! if !@games.empty?
  end

  def show
    @game = Game.find(params[:id])
  end
  
  def add
    redirect_to :action => 'new'
  end
  
  def new
    @game = Game.new(params[:game])
    3.times {@game.player_stats.build({:stat_type_id => 100})}
    #@leagues = active_account().leagues
    @teams = Team.all_teams(active_account())
    @player_stat_types = StatType.player_stats
    @player_game_played = StatType.player_game_played
    @game.date = Time.now
    @game.team1 = @teams[0]
    @game.team2 = @teams[1]
    @teams_on_card = [@teams[0], @teams[1]]
    @members = {}
    @members[@teams[0].id] = @teams[0].members_in_number_order if !@teams[0].nil?
    @members[@teams[1].id] = @teams[1].members_in_number_order if !@teams[1].nil?
  end
  
  def create
    @game = Game.new(params[:game])
    @game.league_id = @game.team1.league_id
    if @game.save
      flash[:notice] = 'Game saved'
      if @game.completed
        @game.update_league
        flash[:notice] = 'Game created'
        redirect_to :action => 'list'
      end
    else
      render :action => 'new'
    end      
  end
    
  def edit
    @game = Game.find(params[:id])
    @teams_on_card = [@game.team1, @game.team2]
    @teams = Team.all_teams(active_account())
    @player_stat_types = StatType.player_stats
    @player_game_played = StatType.player_game_played
    
    @members = {@game.team1_id => [], @game.team2_id => []}  
    @members[@game.team1_id] = @game.players_in_number_order(@game.team1)
    @members[@game.team2_id] = @game.players_in_number_order(@game.team2)
  end

  def upate
    @game = Game.new(params[:game])
    @game.league_id = @game.team1.league_id
    if @game.save
      flash[:notice] = 'Game saved'
      if @game.completed
        @game.update_league
        flash[:notice] = 'Game created'
        redirect_to :action => 'list'
      elsif @game.update
        @game.league.refresh!
        flash[:notice] = 'Game updated'
        redirect_to :action => 'list'
      end
    else
      render :action => 'new'
    end  
  end
  
  def destroy
    Game.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def replace_team
    #@game = Game.find(params[:gameid])
    @team = Team.find(params[:teamid])
    @whichteam = params[:team]
    @members = {@team.id => @team.members_in_number_order}
    respond_to do |format|
      format.html { redirect_to :new}
      format.js {}
    end
  end
  
  def calendar_month_change
    month = Date.new(params[:id])
    selected_date = Date.new(session[:game_date])
  end 
end
