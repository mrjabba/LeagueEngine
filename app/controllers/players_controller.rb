class PlayersController < ApplicationController
  layout :determine_layout
  before_filter :require_user
  
  def index
    list
    render :action => 'list'
  end
  
  def list
    @teams = Team.all_teams(active_account())
  end
  
  def stats
    team = params[:team]
    teamname = params[:id]
    @teams = Team.all_teams(active_account()).sort_by{|team| team[:name]}
    @stat  = StatType.find_by_name("GamePlayed")
  end
  
  def merge
    players = params[:players]
    playername = params[:player_name]
    if(players.count > 1)
      Player.merge!(players, playername)
      flash[:message] = 'Players merged'
      redirect_to :action => 'list'
    else
      flash[:message] = 'No one to merge'
      redirect_to :action => 'list'
    end
  end
  
  def determine_layout 
    return 'print' if params[:action] == 'stats'
    'application'  
  end
end
