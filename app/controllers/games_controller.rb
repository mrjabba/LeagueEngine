class GamesController < ApplicationController
  before_filter :require_user

  def index
    list
    render :action => 'list'
  end

  def list
    #@games = all_games_for_account()
    @played_games = played_games()
    @upcoming_games = upcoming_games() 
  end
  
  def played
    @games = played_games()
  end
  
  def upcoming
    @games = upcoming_games()
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
    required_for_view
    @game.date = Time.now
    @game.team1 = @teams[0]
    @game.team2 = @teams[1]
    @teams_on_card = [@teams[0], @teams[1]]
    @members[@team[0]] = @team[0].members_in_number_order if !@team[0].nil?
    @members[@team[1]] = @team[1].members_in_number_order if !@team[1].nil?
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

  def required_for_view
    @teams = Team.all_teams(active_account())
    @player_stat_types = StatType.player_stats
    @player_game_played = StatType.player_game_played
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
    #@whichteam = params[:team]
    @members[@team] = @team.members_in_number_order
    respond_to do |format|
      format.html { redirect_to :new}
      format.js {}
    end
  end
  
  def calendar_month_change
    month = Date.new(params[:id])
    selected_date = Date.new(session[:game_date])
  end 
  
  private
  def all_games_for_account()
    games = []
    for league in Account.get_active_account(session[:user]).leagues
      for game in league.games
        games << game
      end
    end
    return games
  end
  
  def played_games()
    return Game.get_played_games(active_account())
  end
  
  def upcoming_games()
    return Game.get_upcoming_games(active_account())
  end
end
