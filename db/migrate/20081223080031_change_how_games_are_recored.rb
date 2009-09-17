class ChangeHowGamesAreRecored < ActiveRecord::Migration
  def self.up
    #remove_column :games, :team1_id
    #remove_column :games, :team2_id
    remove_column :game_stats, :stat_type_id
    remove_column :game_stats, :value
    
    add_column :game_stats, :stats, :text
    add_column :game_stats, :team_number, :integer
    add_column :games, :recorded, :integer
  end

  def self.down
    #add_column :games, :team1_id, :integer
    #add_column :games, :team2_id, :integer
    add_column :game_stats, :stat_type_id, :integer
    add_column :game_stats, :value, :integer
    
    remove_column :game_stats, :stats
    remove_column :game_stats, :team_number
    remove_column :games, :recorded
  end
end
