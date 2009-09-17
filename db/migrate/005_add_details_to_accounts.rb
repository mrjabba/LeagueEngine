class AddDetailsToAccounts < ActiveRecord::Migration
  def self.up
    rename_column :accounts, :web_address, :url
    add_column :accounts, :sport, :text
  end

  def self.down
    rename_column :accounts, :url, :web_address
    remove_column :accounts, :sport
  end
end
