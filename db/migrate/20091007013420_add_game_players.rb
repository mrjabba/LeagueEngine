class AddGamePlayers < ActiveRecord::Migration
  def self.up
    create_table :game_players do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :number
    end
    
    add_column :player_stats, :team_id, :integer
  end

  def self.down
    drop_table :game_players
    
    remove_column :player_stats, :team_id
  end
end
