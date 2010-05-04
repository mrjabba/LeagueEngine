class AddTeamTagToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :team_tag, :text
  end

  def self.down
    remove_column :teams, :team_tag
  end
end
