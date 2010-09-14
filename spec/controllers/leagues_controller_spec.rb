require 'spec_helper'

describe Admin::LeaguesController do
   
  describe 'creating a new league' do
    describe 'when successful' do
      before do
        @user = Factory(:user, :username => 'test')
        au = Factory(:accounts_user, :user => @user)
        @account = au.account
        controller.stub!(:active_account).and_return(@account)
        
        activate_authlogic
        UserSession.create @user
        
        (1..3).each do |i|
          Factory(:stat_type, :account => @account, :entity => 'LeagueStat')
        end
        
        @good_params = {
          :league => 
            { :name => 'new_league', 
              :new_team_attributes => [{:name =>'one'}, {:name =>'two'}, {:name => 'three'}, {:name =>'four'}]
            }
        }
        
        post :create, @good_params
        @new_league = League.find_by_name('new_league')
      end
      
      it 'should create a new league with 4 teams' do
        @new_league.should_not be_nil
        @new_league.teams.size.should == 4
      end
    
      it 'should create new league_stats' do   
        @new_league.stats.size.should == 4 * 3
      end  
    end # describe 'when successful' do  
  end # describe 'creating a new account' do
end