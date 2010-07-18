class ModifyLeagueTabel < ActiveRecord::Migration
  def self.up
    remove_column :leagues, :default_stats 
  end

  def self.down
      add_column :leagues, :default_stats, :integer
      remove_column :leagues, :created_at
  end
end
