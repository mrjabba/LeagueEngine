class FixStatTables < ActiveRecord::Migration
  def self.up
    create_table :league_stats do |l|
      l.integer :league_id
      l.integer :team_id
      l.integer :stat_type_id
      l.integer :value 
    end
    
    create_table :team_stats do |t|
      t.integer :team_id
      t.integer :game_id
      t.integer :stat_type_id
      t.integer :value 
    end    
    
    add_column :player_stats, :period, :string
    add_column :stat_types, :short_desc, :string
    add_column :stat_types, :display, :string
    add_column :stat_types, :display_order, :integer, :default => 0
    add_column :stat_types, :sort_order, :integer, :default => 0
    
    drop_table :game_stats
    drop_table :league_lists
    drop_table :league_stat_types
    drop_table :menu_items
    drop_table :menu_items_roles
    drop_table :table_buttons
    drop_table :buttons
    drop_table :signupmails
  end

  def self.down
    drop_table :league_stats
    drop_table :team_stats
    
    remove_column :player_stats, :period
    remove_column :stat_types, :short_desc
  end
end
