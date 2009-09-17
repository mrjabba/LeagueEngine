class CreateSports < ActiveRecord::Migration
    def self.up
      create_table :sports do |t|
        t.column :name, :string
      end
      remove_column :accounts, :sport
      add_column :accounts, :sport_id, :integer
    end

    def self.down
      drop_table :sports
      add_column :accounts, :sport, :string
      remove_column :accounts, :sport_id
    end
  end
