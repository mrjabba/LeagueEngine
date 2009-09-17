class AddStatTypeEntity < ActiveRecord::Migration
  def self.up
    add_column :stat_types, :entity, :string
  end

  def self.down
    remove_column :stat_types, :entity
  end
end
