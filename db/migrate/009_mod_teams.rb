class ModTeams < ActiveRecord::Migration
  def self.up
    rename_column :teams, :display_name, :name
    remove_column :teams, :desc_name
  end

  def self.down
    rename_column :teams, :name, :display_name
    add_column :teams, :desc_name, :string
  end
end
