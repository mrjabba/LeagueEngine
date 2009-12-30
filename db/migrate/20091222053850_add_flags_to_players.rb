class AddFlagsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :junior, :integer
    add_column :players, :sex, :text
  end

  def self.down
    remove_column :players, :junior
    remove_column :players, :sex
  end
end
