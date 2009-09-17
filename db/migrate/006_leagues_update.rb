class LeaguesUpdate < ActiveRecord::Migration
  def self.up
    add_column :leagues, :default_stats, :integer
    remove_column :leagues, :description
    remove_column :leagues, :closed
  end

  def self.down
    remove_column :leagues, :default_stats
    add_column :leagues, :description, :text
    add_column :leagues, :closed, :datetime
  end
end
