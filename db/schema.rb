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

ActiveRecord::Schema.define(version: 20150426023735) do

  create_table "anchors", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.text     "url"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["post_id"], name: "index_images_on_post_id"

  create_table "locations", force: true do |t|
    t.string   "level"
    t.string   "code"
    t.string   "shortName"
    t.string   "longName"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "heading"
    t.text     "body"
    t.decimal  "price"
    t.string   "neighborhood"
    t.string   "external_url"
    t.string   "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "year"
    t.string   "phone"
    t.string   "state"
    t.string   "city"
    t.string   "zipcode"
    t.string   "paint_color"
    t.string   "drive"
    t.integer  "flagged_status"
    t.string   "model_vehicle"
    t.string   "make_vehicle"
    t.string   "type_vehicle"
    t.string   "title_status"
    t.string   "fuel_vehicle"
    t.integer  "rating"
    t.integer  "isDuplicate"
    t.string   "mileage"
    t.string   "transmission"
    t.string   "account_id"
    t.string   "source_map_google"
    t.string   "created_date"
    t.integer  "user_rating"
    t.datetime "created_timestamp"
    t.string   "created_month"
    t.integer  "created_year"
    t.integer  "created_day"
    t.integer  "duplicateCount"
    t.string   "dummyStr1"
    t.string   "dummyStr2"
    t.string   "dummyStr3"
    t.integer  "dummyInt1"
    t.integer  "dummyInt2"
    t.integer  "dummyInt3"
    t.string   "created_on"
    t.string   "vin_no"
    t.string   "size"
    t.integer  "likeCount"
    t.integer  "dislikeCount"
    t.string   "source_heading"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
