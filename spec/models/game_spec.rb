require 'spec_helper'

=begin
{"game"=>{"game_completed"=>"Game Completed", "new_player_stats"=>[{"number"=>"1", "stat_type_id"=>"3", "time"=>"102", "value"=>"", "team_id"=>"1"}, {"number"=>"2", "stat_type_id"=>"5", "time"=>"304", "value"=>"", "team_id"=>"2"}], "teams"=>{"1"=>{"players"=>["tim", "", "", "", "", "", "", "", "", "", "", "", "", ""]}, "2"=>{"players"=>["", "", "", "", "", "tom", "", "", "", "", "", "", "", ""]}}, "team2_goals"=>"0", "team1_goals"=>"0", "time"=>"12:50", "where"=>"", "date_dmy"=>"08 July 2010", "team2_id"=>"2", "team1_id"=>"1"}, "action"=>"create", "authenticity_token"=>"vFCFz9zuOks0yugIdbQ5/PGATnU9DGueBOjaK+CtFfM=", "controller"=>"games"}
=end
describe Game do
  describe 'teams and new_player_stats' do
    before(:each) do
      @game = Factory.build(:game)
      @game.teams = {
        "1"=>{'players'=>["tim", "", ""]}, 
        "2"=>{'players'=>["", "", "tom", ""]}
      }
      
    end
    
    it 'should add PlayerStats for both GamePlayed and goals' do
      @game.new_player_stats = [{"number"=>"1", "stat_type_id"=>"3", "time"=>"102", "value"=>"", "team_id"=>"1"}, 
                                {"number"=>"2", "stat_type_id"=>"3", "time"=>"304", "value"=>"", "team_id"=>"2"}]
      
      @game.save
      Player.all.size.should == 2
      PlayerStat.all.size.should == 4
    end
  end
  
  describe 'teams and existing_player_stats' do
    it 'should update PlayerStats for both GamePlayed and goals' do
      @game = Factory(:game)
      
      
      @game.save
      Player.all.size.should == 2
      PlayerStat.all.size.should == 4
    end
  end
  
  it 'should clear players team members numbers when saving team sheet'
end