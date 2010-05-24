class AddTeamToPlayerStat < ActiveRecord::Migration
  def self.up
    add_column :player_stats, :team_id, :integer
  end

  def self.down
    remove_column :player_stats, :team_id
  end
end
