class CreateStatTypes < ActiveRecord::Migration
  def self.up
    create_table :stat_types do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :stat_types
  end
end
