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

ActiveRecord::Schema.define(:version => 20110227143437) do

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.string   "race"
    t.string   "klass"
    t.string   "build"
    t.integer  "strength"
    t.integer  "constitution"
    t.integer  "dexterity"
    t.integer  "intelligence"
    t.integer  "wisdom"
    t.integer  "charisma"
    t.integer  "strength_modifier"
    t.integer  "constitution_modifier"
    t.integer  "dexterity_modifier"
    t.integer  "intelligence_modifier"
    t.integer  "wisdom_modifier"
    t.integer  "charisma_modifier"
    t.integer  "armor_class"
    t.integer  "fortitude"
    t.integer  "reflex"
    t.integer  "will"
    t.integer  "hit_points"
    t.integer  "current_hit_points"
    t.integer  "temporary_hit_points"
    t.integer  "healing_surges"
    t.integer  "current_healing_surges"
    t.string   "sheet_file_name"
    t.string   "sheet_content_type"
    t.integer  "sheet_file_size"
    t.datetime "sheet_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "powers", :force => true do |t|
    t.integer  "character_id"
    t.string   "name"
    t.string   "power_usage"
    t.string   "action_type"
    t.string   "compendium_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "powers", ["character_id"], :name => "index_powers_on_character_id"
  add_index "powers", ["name"], :name => "index_powers_on_name"

end
