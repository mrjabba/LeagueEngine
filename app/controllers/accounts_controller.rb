class AccountsController < ApplicationController
  def new
    @account = Account.new()
    @user = User.new()
    @sports = Sport.find(:all, :order => "name")      
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
          @account.create_default_data
        end
      rescue ActiveRecord::RecordInvalid => e 
        @account.valid?
        @user.valid? # force checking of errors even if products failed 
        @sports = Sport.find(:all, :order => "name")
      else
        #session[:user] = User.authenticate(@user.login, @user.password)

        flash[:message] = "Signup successful"
        redirect_to admin_leagues_path
      end
    end
  end
end
