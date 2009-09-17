class AccountsController < ApplicationController
  #layout :determine_layout 
  #before_filter :require_user, :except => [:new, :pricing]
  #after_filter :last_rendered_page, :except => [:signup, :pricing]
  
  def index
    list
    render :action => 'list'
  end
  
  def list 
    user = User.find(session[:user])
    if user.god?
      @accounts = Account.find(:all)
    else
      @accounts = user.accounts
    end
  end
  
  def select
    account = Account.find(params[:id]);
    user = User.find(session[:user])
    currentActiveAcc = AccountsUser.find_active_account(user.id)
    currentActiveAcc.active = 0
    currentActiveAcc.save
    
    selectedAcc = AccountsUser.find_row(account.id, user.id)
    if selectedAcc.blank?
      if user.god?
        newAU = AccountsUser.new
        newAU.account_id = account.id
        newAU.user_id = user.id
        newAU.role_id = currentActiveAcc.role_id
        newAU.active = 1
        newAU.save
        flash[:notice] = 'Account link created'
      else
        flash[:notice] = 'Nice Try'
      end
    else
      logger.error("selectedAcc")
      logger.error(selectedAcc)
      selectedAcc.active = 1
      selectedAcc.save
      flash[:notice] = 'Account selected'
    end  
    redirect_to :action => 'list'
  end

  def new
    @account = Account.new()
    @user = User.new()     
  end
  
  def create
    @account = Account.new(params[:account])
    @user = User.new(params[:user])
    if request.post?
      au = AccountsUser.new
      au.role_id = 2 #give them an admin role
      au.active = 1
      begin          
        Account.transaction do
          @user.save!
          @account.owner_id = @user.id
          @account.save!
          au.account_id = @account.id
          au.user_id = @user.id
          au.save!
        end
      rescue ActiveRecord::RecordInvalid => e 
        @account.valid?
        @user.valid? # force checking of errors even if products failed 
        #render :action => :signup
      else
        #session[:user] = User.authenticate(@user.login, @user.password)
        #generates default league, teams and games as a demo to new users
        League.generate_default_league(@account)

        flash[:message] = "Signup successful"
        redirect_to :controller => "leagues", :action => "list"
      end
    end
  end
  
  def pricing
  end
  
  private
  def determine_layout 
    return "nomenu" if params[:action] =~ /signup|pricing/
    'master' 
    #return  "base2" 
  end
end
