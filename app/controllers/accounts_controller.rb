class AccountsController < ApplicationController
  def new
    @account = Account.new()
    @user = User.new()
    @sports = Sport.find(:all, :order => "name")      
  end
  
  def create
    @account = Account.default(params[:account])
    @user = User.new(params[:user])
    
    if request.post?
      begin          
        Account.transaction do
          @user.save!
          @account.owner_id = @user.id
          @account.save!
          @account.stats   << StatType.default_stats #@account.sport ? self.sport.stats : StatType.DEFAULT_STATS
          @account.leagues << League.default({:account => @account})
          
          
          AccountsUser.create({
            :role => Role.admin, 
            :active => true,
            :account => @account,
            :user => @user
          })
        end
      rescue ActiveRecord::RecordInvalid => e 
        @account.valid?
        @user.valid? # force checking of errors even if accounts failed 
        @sports = Sport.find(:all, :order => "name")
      else
        #session[:user] = User.authenticate(@user.login, @user.password)

        flash[:message] = "Signup successful"
        redirect_to admin_leagues_path
      end

    end
  end
end
