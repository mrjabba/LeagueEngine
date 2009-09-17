class AddSubMenu < ActiveRecord::Migration
  def self.up
    add_column :menu_items, :sub_menu, :text
  end

  def self.down
    remove_column :menu_items, :sub_menu
  end
end
