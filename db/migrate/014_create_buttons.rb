class CreateButtons < ActiveRecord::Migration
    def self.up
      create_table :buttons do |t|
        t.column :name, :string
        t.column :src, :string
        t.column :folder, :string
      end
    end

    def self.down
      drop_table :buttons
    end
end
