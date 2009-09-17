class ModGameStats < ActiveRecord::Migration
  def self.up
    remove_column :game_stats, :goals
    remove_column :game_stats, :exclusions
    remove_column :game_stats, :converstions
    add_column :game_stats, :stat_type_id, :integer
    add_column :game_stats, :value, :integer        
  end

  def self.down
    add_column :game_stats, :goals, :integer
    add_column :game_stats, :exclusions, :integer
    add_column :game_stats, :conversions, :integer
    remove_column :game_stats, :stat_type_id
    remove_column :game_stats, :value  
  end
end
