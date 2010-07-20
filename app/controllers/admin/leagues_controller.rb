class LeaguesController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    @leagues = active_account.leagues
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
      #format.rss  # index.rss.builder
    end
  end
  
  def new
    @league = League.new(params[:league])
  end
  
  def create
    @league = League.new(params[:league])
    @league.account_id = active_account.id
    if @league.save
      @league.generate_league_data
      flash[:notice] = "League Created"
      redirect_to :controller => "leagues", :action => "index"
    else
      render :action => :new
    end
  end
  
  def show
    @league = League.find(params[:id])
  end
  
  def edit
    @league = League.find(params[:id])
  end
  
  def update
    @league = League.find(params[:id])
  end
  
  def destroy
	  if request.post?
		  @league = League.find(params[:id])
		  @league.clean_delete(@league)
	  end
	  redirect_to(:action => :list) 
  end
  
  def league_list
    @league = League.find(params[:id])
    
    respond_to do |format|
      format.html {}
      format.xml  { render :xml => @league }
      format.js   {}  
      #format.rss  # index.rss.builder
    end
  end
  
  def add_team
    @leagues = active_account().leagues
    @team = Team.new(params[:team])
    @team.league_id = params[:id] if params[:id]
    if request.post?
      if @team.save
        @team.generate_team_data()
        flash[:notice] = "Team Created"
        
        #resets form ready to add another team
        l = @team.league_id
        @team = Team.new()
        @team.league_id = l
      end
    end
  end
  
  def remove_team
    @teams = []
    for id in session[:items] do
      @teams << Team.find(id)
    end
  end  
  
  def determine_layout 
    return 'blank' if params[:action] =~ /league_plugin/ 
    return 'application'
    #return  "base2"
    #return "test" 
  end  
end
