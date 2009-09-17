class CreateLeagueStats < ActiveRecord::Migration
  def self.up
    drop_table :league_list_headers
    create_table :league_stats do |t|
      t.column :league_id, :integer
      t.column :name, :string
      t.column :tag, :string
      t.column :order, :integer
    end
  end

  def self.down
    drop_table :league_stats
    create_table "league_list_headers", :force => true do |t|
      t.column "headings",  :text
      t.column "league_id", :integer, :null => false
    end
  end
end
