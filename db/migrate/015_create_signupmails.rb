class CreateSignupmails < ActiveRecord::Migration
  def self.up
    create_table :signupmails do |t|
    end
  end

  def self.down
    drop_table :signupmails
  end
end
