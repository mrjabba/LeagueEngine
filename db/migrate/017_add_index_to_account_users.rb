class AddIndexToAccountUsers < ActiveRecord::Migration
  def self.up
    add_column :accounts_users, :id, :integer
  end

  def self.down
    remove_column :teams, :desc_name
  end
end
