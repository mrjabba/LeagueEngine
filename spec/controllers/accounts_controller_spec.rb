require 'spec_helper'

describe AccountsController do
  describe 'should route' do
  end
  
  describe 'creating an account' do
    before(:each) do
      @default_league = Factory(:league, :name => 'DefaultLeague')
      
      (1..3).each do |i|
        Factory(:stat_type, :name => "stat#{i}", :account_id => @default_league.account.id)
      end
      
      
      (1..4).each do |i|
        #league
        team = Factory(:team, :league_id => @default_league.id)
        Factory(:league_stat, :league_id => @default_league.id, :team_id => team, :stat_type_id => StatType.find(1).id)
      end
      

    end
    
    it 'should create a new account with default league, teams and stats' do
      post :create, {
        :account => {:name => 'new', :sport_id => 1},
        :user => {:username => 'new_guy', :password => 'password', :password_confirmation => 'password', :email => 'new_guy@somewhere.com'}
      }
      acc = Account.find_by_name('new')
      acc.should_not be_nil
      acc.leagues.first.teams.size.should == 4
      acc.stats.size.should == 3
    end
  end
end