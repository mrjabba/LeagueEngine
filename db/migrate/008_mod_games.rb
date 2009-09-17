class ModGames < ActiveRecord::Migration
  def self.up
    add_column :games, :completed, :integer
  end

  def self.down
    remove_column :games, :completed
  end
end
