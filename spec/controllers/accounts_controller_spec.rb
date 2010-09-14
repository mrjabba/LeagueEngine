require 'spec_helper'

describe AccountsController do
  describe 'creating a new account' do
    describe 'when successful' do
      before do
        @good_params = {
          :account => {:name => 'new', :other_sport_name => 'Slacking'},
          :user =>    {:username => 'new_guy', :password => 'password', :email => 'new_guy@somewhere.com'}
        }
      
        post :create, @good_params
        @new_acc = Account.find_by_name('new')
      end
      
      it 'should create a new account with default a league and teams' do
        @new_acc.should_not be_nil
        @new_acc.leagues.size.should >= 1
        @new_acc.leagues.first.teams.size.should == 4
      end

    
      it 'should create new league_stats' do
        teams = @new_acc.leagues.first.teams.size
        league_stats = StatType.default_stats.select{|s| s.entity == 'LeagueStat'}.size
        stat_count = teams * league_stats
        new_league = @new_acc.leagues.first
        
        new_league.stats.size.should == stat_count
      end  
        
      it 'should create new stat_types' do
        @new_acc.stats.size.should == StatType.default_stats.size
      end      
    end # describe 'when successful' do  
  end # describe 'creating a new account' do
end