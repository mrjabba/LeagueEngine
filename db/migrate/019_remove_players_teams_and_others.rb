class RemovePlayersTeamsAndOthers < ActiveRecord::Migration
  def self.up
    drop_table :players_teams
    remove_column :players, :account_id
  end

  def self.down
    create_table "players_teams", :force => true do |t|
      t.column "player_id",    :integer,  :null => false
      t.column "team_id",      :integer,  :null => false
      t.column "shirt_number", :integer
      t.column "created_at",   :datetime
    end
    add_column :players, :account_id
  end
end
