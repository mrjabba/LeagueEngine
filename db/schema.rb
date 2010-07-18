# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100714061341) do

  create_table "accounts", :force => true do |t|
    t.string   "name",       :default => ""
    t.integer  "owner_id"
    t.string   "url",        :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sport_id"
  end

  create_table "accounts_users", :force => true do |t|
    t.integer "account_id"
    t.integer "user_id"
    t.integer "role_id"
    t.integer "active"
  end

  create_table "games", :force => true do |t|
    t.integer  "league_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.datetime "date"
    t.integer  "completed"
    t.string   "where"
    t.integer  "recorded"
  end

  create_table "league_stats", :force => true do |t|
    t.integer "league_id"
    t.integer "team_id"
    t.integer "stat_type_id"
    t.integer "value"
  end

  create_table "leagues", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_stats", :force => true do |t|
    t.integer "game_id"
    t.integer "player_id"
    t.integer "number",       :default => 0
    t.integer "stat_type_id"
    t.integer "value"
    t.integer "team_id"
    t.string  "period"
  end

  create_table "players", :force => true do |t|
    t.string   "full_name",   :limit => 100, :default => ""
    t.datetime "dob"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "junior"
    t.text     "sex"
  end

  create_table "roles", :force => true do |t|
    t.string "name", :limit => 20, :default => ""
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sports", :force => true do |t|
    t.string "name"
  end

  create_table "stat_types", :force => true do |t|
    t.string  "name"
    t.string  "entity"
    t.integer "account_id"
    t.string  "short_desc"
    t.string  "display"
  end

  create_table "team_members", :force => true do |t|
    t.integer "team_id"
    t.integer "player_id"
    t.integer "number"
  end

  create_table "team_stats", :force => true do |t|
    t.integer "team_id"
    t.integer "game_id"
    t.integer "stat_type_id"
    t.integer "value"
  end

  create_table "teams", :force => true do |t|
    t.integer "league_id"
    t.string  "name",      :limit => 100, :default => ""
    t.string  "captain",   :limit => 100
    t.text    "team_tag"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
