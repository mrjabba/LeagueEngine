class AddOtherSportNameToAccounts < ActiveRecord::Migration
  def self.up
    add_column 'accounts', 'other_sport_name', :string
  end

  def self.down
    remove_column 'accounts', 'other_sport_name'
  end
end
