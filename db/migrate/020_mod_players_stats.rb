class ModPlayersStats < ActiveRecord::Migration
  def self.up
    remove_column :player_stats, :goals
    remove_column :player_stats, :exclusions
    add_column :player_stats, :stat_type_id, :integer
    add_column :player_stats, :value, :integer
  end

  def self.down
    add_column :player_stats, :goals, :integer
    add_column :player_stats, :exclusions, :integer
    remove_column :player_stats, :stat_type_id
    remove_column :player_stats, :value
  end
end
