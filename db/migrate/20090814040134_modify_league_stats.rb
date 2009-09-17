class ModifyLeagueStats < ActiveRecord::Migration
  def self.up
    rename_table :league_stats, :league_stat_types
    add_column :league_stat_types, :formula, :text
  end
  
  def self.down
    remove_column :league_stat_types, :formula
    rename_table :league_stat_types, :league_stats
  end
end
