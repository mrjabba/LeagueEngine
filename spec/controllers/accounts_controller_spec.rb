require 'spec_helper'

describe AccountsController do
   
  describe 'creating a new account' do
    before(:each) do
      @default_league = Factory(:league, :name => 'DefaultLeague')
      
      (1..3).each do |i|
        Factory(:stat_type, :name => "stat#{i}", :account_id => @default_league.account.id)
      end
      
      
      (1..4).each do |i|
        team = Factory(:team, :league_id => @default_league.id)
        (1..3).each do |j|
          Factory(:league_stat, :league_id => @default_league.id, :team_id => team.id, :stat_type_id => StatType.all[j-1].id)
        end
      end
    end
    
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
      
      it 'should not be the basline default league' do
        lambda{ @new_acc.leagues.find(@default_league.id)}.should raise_error ActiveRecord::RecordNotFound
      end
      
      it 'should create new teams, not reference the defaults' do  
        @default_league.teams.each do |t|
          lambda{ @new_acc.leagues.first.teams.find(t.id)}.should raise_error ActiveRecord::RecordNotFound
        end
      end
      
      it 'should create new league_stats and not reference defaults' do
        new_league = @new_acc.leagues.first
        new_league.stats.size.should == 12
      
        new_league.stats.each do |s|
          lambda{ @default_league.stats.find(s.id)}.should raise_error ActiveRecord::RecordNotFound  
        end
      end  
        
      it 'should create new stat_types and not ref defaults' do
        @new_acc.stats.size.should == 3
        
        @default_league.account.stats.each do |s|
          lambda{ @new_acc.stats.find(s.id)}.should raise_error ActiveRecord::RecordNotFound  
        end
      end      
    end # describe 'when successful' do  
  end # describe 'creating a new account' do
end
