class Admin::GamesController < Admin::AdminController
  before_filter :require_user

  def index
    @games = active_account.games.all(:order => 'date desc')
  end

  def show
    @game = Game.find(params[:id])
  end
  
  def add
    redirect_to :action => 'new'
  end
  
  def new
    @game = Game.new(params[:game])
    3.times {@game.player_stats.build()}
    @leagues = active_account().leagues
    @teams = Team.all_teams(active_account())
    @player_stat_types = active_account.stat_types.player_without_gameplayed
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
        @game.add_result_to_league
        flash[:notice] = 'Game created'
        redirect_to :action => 'index'
      end
      render :action => 'edit', :id => @game.id
    else
      render :action => 'edit'
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
  
  def update
    old_game = Game.find(params[:id])
    @game = Game.find(params[:id]) #old_game.dup
    
    if @game.update_attributes(params[:game])
      if @game.completed? && !old_game.completed?
        @game.add_result_to_league
        flash[:notice] = 'Game saved, League updated'
        redirect_to :action => 'index'
      elsif @game.completed? && old_game.completed? 
        flash[:notice] = 'Game updated'      
        @game.update_league if @game.score_changed?(old_game)
        redirect_to :action => 'index'
      else
        flash[:notice] = 'Game saved'
        render :action => "edit"
      end
    else
      render :action => "edit"
    end  
  end
  
  def destroy
    game = Game.find(params[:id])
    league = game.league
    game.destroy
    league.refresh_league!
    redirect_to :action => 'index'
  end
  
  def replace_team
    #@game = Game.find(params[:gameid])
    @team = Team.find(params[:teamid])
    @whichteam = params[:team]
    @members = {@team.id => @team.members_in_number_order}
    @all_members = @team.players
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
