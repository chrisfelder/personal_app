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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150303125340) do

  create_table "challenges", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.integer  "strength"
    t.integer  "defense"
    t.integer  "hp_current"
    t.integer  "hp_max"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.integer  "miner",      default: 0
    t.integer  "lumberjack", default: 0
    t.integer  "hunter",     default: 0
    t.integer  "builder",    default: 0
    t.integer  "farmer",     default: 0
  end

  add_index "characters", ["user_id"], name: "index_characters_on_user_id"

  create_table "experiments", force: :cascade do |t|
    t.string   "save_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "experiments", ["save_state"], name: "index_experiments_on_save_state"

  create_table "gamestores", force: :cascade do |t|
    t.string   "name"
    t.integer  "turn"
    t.integer  "char1"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "gamestores", ["user_id", "created_at"], name: "index_gamestores_on_user_id_and_created_at"
  add_index "gamestores", ["user_id"], name: "index_gamestores_on_user_id"

  create_table "tracks", force: :cascade do |t|
    t.string   "name"
    t.text     "input"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "trial_time"
    t.integer  "calibration_time"
    t.integer  "recalibration_time"
    t.integer  "number_of_trials"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
