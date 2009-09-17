class AddWhereToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :where, :string
  end

  def self.down
    remove_column :games, :where
  end
end
