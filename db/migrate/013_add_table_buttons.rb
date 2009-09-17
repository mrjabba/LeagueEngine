class AddTableButtons < ActiveRecord::Migration
  def self.up
    create_table :table_buttons do |t|
      t.column :table_name, :string
      t.column :button_id, :integer
      t.column :link_to_controller, :string
      t.column :link_to_action, :string
      t.column :alt_text, :string
      t.column :order, :integer
    end
  end

  def self.down
    drop_table :table_buttons
  end
end

