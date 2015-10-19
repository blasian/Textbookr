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

ActiveRecord::Schema.define(version: 20151016171559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "au_lname",   null: false
    t.string   "au_fname",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "book_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer  "isbn"
    t.integer  "volume"
    t.string   "edition"
    t.string   "title",                          null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_account_id",                null: false
    t.boolean  "active",          default: true, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "department"
    t.integer  "course_number"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "book_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "price"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "book_id",     null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string   "title"
    t.float    "price_min"
    t.float    "price_max"
    t.string   "author"
    t.string   "department"
    t.integer  "user_account_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "alert",           default: false
    t.text     "groupings"
    t.string   "combinator"
    t.integer  "course_number"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.boolean  "isAdmin?",               default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "user_accounts", ["email"], name: "index_user_accounts_on_email", unique: true, using: :btree
  add_index "user_accounts", ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "authors", "books"
  add_foreign_key "books", "user_accounts"
  add_foreign_key "courses", "books"
  add_foreign_key "posts", "books", name: "book_id"
  add_foreign_key "searches", "user_accounts"
end
