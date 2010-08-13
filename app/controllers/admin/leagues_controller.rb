class Admin::LeaguesController < Admin::AdminController

  def index
    @leagues = active_account.leagues
    @display_stats = active_account.stats.league_display 
    @sorting_stats = active_account.stats.league_sorting
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
      format.json  { render :json => @leagues.t_json }
    end
  end
  
  def new
    @league = League.new(params[:league])
    @teams = []
    4.times{ @teams << Team.new}
  end
  
  def create
    @league = nil
    League.transaction do
      begin
        @league = League.create(params[:league].merge({:account_id => active_account.id})) 
      rescue Exception => e
        render :action => :new
      else
        flash[:notice] = "League Created"
        redirect_to :action => "index"
      end
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
    if @league.update_attributes(params[:league])
      flash[:notice] = "League Updated"
      redirect_to :action => "index"
    else
      flash[:notice] = "League Updated"
      redirect_to @league 
    end  
  end
  
  def destroy
	  if request.post?
		  @league = League.find(params[:id])
		  @league.clean_delete(@league)
	  end
	  redirect_to(:action => :list) 
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
end
