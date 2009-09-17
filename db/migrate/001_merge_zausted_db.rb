class MergeZaustedDb < ActiveRecord::Migration
  def self.up
    # This file is autogenerated. Instead of editing this file, please use the
    # migrations feature of ActiveRecord to incrementally modify your database, and
    # then regenerate this schema definition.

      create_table "accounts", :force => true do |t|
        t.column "name",        :string,   :limit => 100, :default => "", :null => false
        t.column "owner_id",    :integer
        t.column "created_on",  :datetime,                                :null => false
        t.column "updated_on",  :datetime
        t.column "web_address", :string,   :limit => 100, :default => "", :null => false
      end

      create_table "accounts_users", :id => false, :force => true do |t|
        t.column "account_id", :integer, :null => false
        t.column "user_id",    :integer, :null => false
        t.column "role_id",    :integer
        t.column "active",     :integer
      end

      create_table "game_stats", :force => true do |t|
        t.column "game_id",      :integer,                :null => false
        t.column "team_id",      :integer,                :null => false
        t.column "goals",        :integer, :default => 0
        t.column "exclusions",   :integer, :default => 0
        t.column "converstions", :integer, :default => 0
      end

      #add_index "game_stats", ["game_id"], :name => "game_id"
      #add_index "game_stats", ["team_id"], :name => "team_id"

      create_table "games", :force => true do |t|
        t.column "league_id", :integer,  :null => false
        t.column "team1_id",  :integer,  :null => false
        t.column "team2_id",  :integer,  :null => false
        t.column "date",      :datetime
      end

      #add_index "games", ["league_id"], :name => "league_id"
      #add_index "games", ["team1_id"], :name => "team1_id"
      #add_index "games", ["team2_id"], :name => "team2_id"

      create_table "league_list_headers", :force => true do |t|
        t.column "headings",  :text
        t.column "league_id", :integer, :null => false
      end

      create_table "league_lists", :force => true do |t|
        t.column "league_id", :integer, :null => false
        t.column "team_id",   :integer, :null => false
        t.column "stats",     :text
      end

      #add_index "league_lists", ["league_id"], :name => "league_id"
      #add_index "league_lists", ["team_id"], :name => "team_id"

      create_table "leagues", :force => true do |t|
        t.column "account_id",  :integer,                                 :null => false
        t.column "name",        :string,   :limit => 100, :default => "", :null => false
        t.column "description", :text
        t.column "closed",      :datetime
      end

      #add_index "leagues", ["account_id"], :name => "account_id"

      create_table "menu_items", :force => true do |t|
        t.column "name", :string, :limit => 20, :default => "", :null => false
      end

      create_table "menu_items_roles", :id => false, :force => true do |t|
        t.column "menu_item_id", :integer, :null => false
        t.column "role_id",      :integer, :null => false
      end

      create_table "player_stats", :force => true do |t|
        t.column "game_id",    :integer,                :null => false
        t.column "player_id",  :integer,                :null => false
        t.column "number",     :integer, :default => 0
        t.column "goals",      :integer, :default => 0
        t.column "exclusions", :integer, :default => 0
      end

      #add_index "player_stats", ["game_id"], :name => "game_id"
      #add_index "player_stats", ["player_id"], :name => "player_id"

      create_table "players", :force => true do |t|
        t.column "account_id", :integer,                                 :null => false
        t.column "name",       :string,   :limit => 100, :default => "", :null => false
        t.column "dob",        :datetime
      end

      #add_index "players", ["account_id"], :name => "account_id"

      create_table "players_teams", :force => true do |t|
        t.column "player_id",    :integer,  :null => false
        t.column "team_id",      :integer,  :null => false
        t.column "shirt_number", :integer
        t.column "created_at",   :datetime
      end

      create_table "roles", :force => true do |t|
        t.column "name", :string, :limit => 20, :default => "", :null => false
      end

      create_table "team_members", :force => true do |t|
        t.column "team_id",   :integer, :null => false
        t.column "player_id", :integer, :null => false
        t.column "number",    :integer
      end

      #add_index "team_members", ["team_id"], :name => "team_id"
      #add_index "team_members", ["player_id"], :name => "player_id"

      create_table "teams", :force => true do |t|
        t.column "league_id",    :integer,                                :null => false
        t.column "display_name", :string,  :limit => 100, :default => "", :null => false
        t.column "captain",      :string,  :limit => 100
        t.column "desc_name",    :string,  :limit => 100, :default => "", :null => false
      end

  end

  def self.down
    drop_table :account_users
    drop_table :accounts
    drop_table :game_stats
    drop_table :games
    drop_table :league_list_headers
    drop_table :league_lists
    drop_table :leagues
    drop_table :menu_items
    drop_table :menu_item_roles
    drop_table :player_stats
    drop_table :players
    drop_table :player_teams
    drop_table :roles
    drop_table :team_members
    drop_table :teams
  end
end
