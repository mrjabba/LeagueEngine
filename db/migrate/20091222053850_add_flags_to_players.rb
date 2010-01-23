class AddFlagsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :first_name, :string
    add_column :players, :middle_name, :string
    add_column :players, :last_name, :string
    add_column :players, :junior, :integer
    add_column :players, :sex, :text
    rename_column :players, :name, :full_name 
  end

  def self.down
    remove_column :players, :first_name
    remove_column :players, :middle_name
    remove_column :players, :last_name
    remove_column :players, :junior
    remove_column :players, :sex
    rename_column :players, :full_name, :name 
  end
end
