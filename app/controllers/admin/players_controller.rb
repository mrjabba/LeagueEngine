class Admin::PlayersController < Admin::AdminController
  layout :determine_layout
  before_filter :require_user
  
  def index
    @team_name = params[:team_name]
    @teams = active_account.teams.all(:conditions => {:name => @team_name}, :order => 'teams.name')  if !@team_name.nil? #Team.all_teams(active_account()).sort_by{|team| team[:name]}
    @teams = active_account.teams.all(:order => 'teams.name')      if @team_name.nil? 
    
    @player_lists = {}
    # {'gosford' => {'seniors' => [], 'juniors' => []}}
    @teams.each do |t|
      juniors = []
      seniors = [] 
      t.players.all(:order => "last_name, first_name").each do |p|
        p.junior ? juniors << p.id : seniors << p.id 
      end
      
      if @player_lists[t.name]      
        #add players but remove dupilcates
        @player_lists[t.name][:juniors] = @player_lists[t.name][:juniors] | juniors #join and remove duplicates
        @player_lists[t.name][:seniors] = @player_lists[t.name][:seniors] | seniors
      else
        @player_lists[t.name] = {:juniors => juniors, :seniors => seniors} 
      end        
    end
    
    # replace ids with acutal player objetcs 
    @player_lists.each do |t|
      t[1][:juniors] = Player.find(t[1][:juniors], :order => "last_name, first_name")
      t[1][:seniors] = Player.find(t[1][:seniors], :order => "last_name, first_name")
    end
  end
  
  def stats
    @team_name = params[:team_name]
    @stat  = StatType.find_by_name(params[:stat]) 
    @stat ||= StatType.player_game_played
    
    @teams = active_account.teams.all(:conditions => {:name => @team_name}, :order => "last_name, first_name")  if !@team_name.nil? #Team.all_teams(active_account()).sort_by{|team| team[:name]}
    @teams = active_account.teams.sort_by { |team| team[:name] }     if @team_name.nil? 
  end
  
  #these are done through the game cards
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
  
  # def destroy
  #   player = Player.find(params[:id])
  #   team = Team.find(params[:team_id])
  #   
  #   if !team.nil? && !player.nil?
  #     
  #     if PlayerStat.delete(:conditions => {:team_id => team.id, :player_id => player.id})
  #       respond_to do |format|
  #         format.html { redirect_to :new}
  #         format.js {}
  #       end
  #     end
  #   end 
  # end
  
  def merge
    @player = Player.find(params[:id])
    @player.same_as_me = params[:same_as_me]
    
    if !@player.same_as_me.nil? && @player.same_as_me.count > 1
      @teams = []
    
      #get all teams for the merged players
      @player.same_as_me.each do |id|
        p = Player.find(id)
        p.teams.each do |t|
          @teams << t.id
        end
      end
      #removes duplicates
      @teams = @teams & @teams
    
      @player.merge!
      @notice = 'Players Merged'
    else
      @error = 'You need to choose atleast two players to do a merge.'
    end
  end
  
  def split_names
    active_account.teams.each do |t|
      t.players.each do |p|
        p.name = p.full_name
        p.save
      end
    end
    flash[:notice] = 'Player Name Split'
    redirect_to :action => :stats
  end
  
  def determine_layout 
    #return 'print' if params[:action] == 'stats'
    'application'  
  end
end
