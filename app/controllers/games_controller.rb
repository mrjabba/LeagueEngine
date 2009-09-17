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
    3.times {@game.player_stats.build}
    @leagues = active_account().leagues
    @teams = Team.all_teams(active_account())
    @game.date = Time.now
    @game.team1 = @teams[0]
    @game.team2 = @teams[1]
  end
  
  def create
    @game = Game.new(params[:game])
      if @game.save
        flash[:notice] = 'Games was successfully created.'
        redirect_to :action => 'list'
      else
        render :action => 'new'
      end      
  end

  def edit
    @game = Game.find(params[:id])
    if request.post?
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Games was successfully updated.'
        redirect_to :action => 'list'
      else
        render :action => 'edit'
      end
    else
      @leagues = active_account().leagues
      @teams = Team.all_teams(active_account())
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
