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

ActiveRecord::Schema.define(version: 20170929091313) do

  create_table "billings", force: :cascade do |t|
    t.integer "trip_id"
    t.integer "catering_costs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "whole_days_count"
    t.integer "half_days_count"
    t.integer "night_count"
    t.integer "addition_for_night"
    t.integer "accommodations_per_diems"
    t.integer "addition_for_half_day"
    t.integer "addition_for_whole_day"
    t.integer "catering_costs_reduction"
    t.integer "breakfast_count"
    t.integer "lunch_count"
    t.integer "dinner_count"
    t.integer "breakfast_reduction"
    t.integer "lunch_reduction"
    t.integer "dinner_reduction"
    t.integer "result"
    t.index ["trip_id"], name: "index_billings_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "user_id"
    t.string "trip_reason"
    t.datetime "trip_start"
    t.datetime "trip_end"
    t.string "trip_departure"
    t.string "trip_arrival"
    t.integer "distance"
    t.integer "night_count", default: 0
    t.integer "breakfast_count", default: 0
    t.integer "lunch_count", default: 0
    t.integer "dinner_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notice"
    t.integer "outlay", default: 0
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
