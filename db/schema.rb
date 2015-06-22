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

ActiveRecord::Schema.define(version: 20150620091050) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.string   "address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "addresses", ["restaurant_id"], name: "index_addresses_on_restaurant_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "dish_id"
    t.integer  "user_id"
    t.integer  "acid"
    t.integer  "sweet"
    t.integer  "bitter"
    t.integer  "spicy"
    t.integer  "salt"
    t.integer  "tasted"
    t.integer  "orderby"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["dish_id"], name: "index_comments_on_dish_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "dish_tagsships", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "dish_tagsships", ["dish_id"], name: "index_dish_tagsships_on_dish_id"
  add_index "dish_tagsships", ["tag_id"], name: "index_dish_tagsships_on_tag_id"

  create_table "dishes", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "price"
    t.integer  "viewed"
    t.integer  "status"
    t.integer  "user_id"
    t.string   "short_des"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "dishes", ["user_id"], name: "index_dishes_on_user_id"

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.integer  "price_level"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
