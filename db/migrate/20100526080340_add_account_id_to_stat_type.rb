class AddAccountIdToStatType < ActiveRecord::Migration
  def self.up
    add_column :stat_types, :account_id, :integer
  end

  def self.down
    remove_column :stat_types, :account_id
  end
end
