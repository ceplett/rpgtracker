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

ActiveRecord::Schema.define(:version => 20110207010824) do

  create_table "campaigns", :force => true do |t|
    t.integer  "gm_id",       :null => false
    t.string   "title",       :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["gm_id"], :name => "index_campaigns_on_gm_id"

  create_table "characters", :force => true do |t|
    t.integer  "player_id"
    t.integer  "campaign_id"
    t.string   "name"
    t.string   "token_file_name"
    t.string   "token_content_type"
    t.integer  "token_file_size"
    t.datetime "token_updated_at"
    t.string   "portrait_file_name"
    t.string   "portrait_content_type"
    t.integer  "portrait_file_size"
    t.datetime "portrait_updated_at"
    t.string   "sheet_file_name"
    t.string   "sheet_content_type"
    t.integer  "sheet_file_size"
    t.datetime "sheet_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "campaign_id", :null => false
    t.string   "email",       :null => false
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["campaign_id"], :name => "index_invitations_on_campaign_id"
  add_index "invitations", ["email"], :name => "index_invitations_on_email"
  add_index "invitations", ["player_id"], :name => "index_invitations_on_player_id"

  create_table "users", :force => true do |t|
    t.string   "name",                                                :null => false
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
