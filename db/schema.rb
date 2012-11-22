# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121122160310) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "admin_email"
    t.boolean  "disabled",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "invitees", :force => true do |t|
    t.integer  "session_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invitees", ["session_id"], :name => "index_invitees_on_session_id"

  create_table "sessions", :force => true do |t|
    t.integer  "account_id"
    t.integer  "host_id"
    t.boolean  "scheduled_session", :default => true
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "sessions", ["account_id"], :name => "index_sessions_on_account_id"

  create_table "users", :force => true do |t|
    t.integer  "account_id"
    t.string   "user_email"
    t.string   "user_access_code"
    t.boolean  "custom_access_code", :default => true
    t.string   "display_name"
    t.string   "time_zone",          :default => "America/Los_Angeles"
    t.boolean  "host_privileges",    :default => true
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"

end
