class Admin::TeamsController < ApplicationController
  #layout 'master'
  before_filter :require_user
  #before_filter :validate_request, :except => [:index, :list, :edit]
  after_filter :store_referrer
  
  def index
    list
  end
  
  def list 
    @teams = all_teams_for_account()
  end
  
  def new
    @team = Team.new(params[:team])
  end
  
  def create
    @team = Team.new(params[:team])
    if @team.save
      @team.generate_team_data
      flash[:notice] = "Team created."
      return redirect_to_referrer_or_default(team_path(@team))
    else
      return redirect_to(@team)
    end
  end
  
  def edit
    @team = Team.find(params[:id])
  end
  
  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:notice] = "team updated."
      return redirect_to_referrer_or_default(team_path(@team))
    else
      return redirect_to(@team)
    end  
  end
  
  def destroy
    @team = Team.find(params[:id])
    if(@team)
      @team.destroy_team_data
      flash[:notice] = "team deleted."
      return redirect_to_referrer_or_default(team_path(@team))
    else
      flash[:notice] = "team does not exist."
      return redirect_to_referrer_or_default(team_path(@team))
    end  
  end
  
  private
  def all_teams_for_account()
    return Team.all_teams(active_account())
  end
  
  #def load_league
   # @league = League.find(params[:id])
    #@league ||= League.find(params[:league_id])
  #end
  
  #def validate_request
   # begin
    #  if Team.find(params[:id]).league.account.id != active_account().id
     #   flash[:notice] = "Team does not exist"
      #  redirect_to session[:last_page]
      #end
    #rescue
     # flash[:notice] = "Team does not exist"
    #  redirect_to session[:last_page]
    #end  
  #end
end
