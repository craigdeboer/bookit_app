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

ActiveRecord::Schema.define(version: 20150203174700) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_limit"
    t.boolean  "location"
    t.boolean  "inventory_tag"
    t.boolean  "wc_stf"
    t.boolean  "pc_features"
    t.boolean  "pc_tilt"
  end

  create_table "bookings", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.integer  "bookable_id"
    t.string   "bookable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "mattresses", force: true do |t|
    t.string   "manufacturer"
    t.string   "model_type"
    t.string   "size"
    t.string   "inventory_tag"
    t.string   "serial_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "location"
  end

  create_table "others", force: true do |t|
    t.string   "manufacturer"
    t.string   "model_type"
    t.string   "inventory_tag"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "location"
  end

  create_table "powerchairs", force: true do |t|
    t.string   "manufacturer"
    t.string   "model_type"
    t.string   "drive"
    t.string   "color"
    t.string   "inventory_tag"
    t.string   "serial_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "location"
    t.boolean  "tilt"
    t.string   "features"
  end

  create_table "scooters", force: true do |t|
    t.string   "manufacturer"
    t.string   "model_type"
    t.string   "wheels"
    t.string   "color"
    t.string   "inventory_tag"
    t.string   "serial_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "location"
  end

  add_index "scooters", ["account_id"], name: "index_scooters_on_account_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "initials"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_digest"
    t.integer  "account_id"
  end

  create_table "wheelchairs", force: true do |t|
    t.string   "manufacturer"
    t.string   "model_type"
    t.integer  "width"
    t.integer  "depth"
    t.string   "color"
    t.string   "inventory_tag"
    t.string   "serial_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "seat_to_floor"
    t.string   "location"
  end

  add_index "wheelchairs", ["account_id"], name: "index_wheelchairs_on_account_id", using: :btree

end
