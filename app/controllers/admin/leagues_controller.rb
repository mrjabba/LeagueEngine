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
    4.times{ @league.teams.build } if params[:league].blank?
  end

  def create
    league_params = {:account => active_account}.merge(params[:league])
    @league = League.new(league_params)
    if @league.save
      flash[:notice] = "League Created"
      redirect_to :action => "index"
    else
      render :action => :new
    end # begin
  end #def create

  def show
    @league = League.find(params[:id])
  end

  def edit
    @league = League.find(params[:id])
    @teams = @league.teams.all(:order => 'name')
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
end
