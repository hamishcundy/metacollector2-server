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

ActiveRecord::Schema.define(version: 20150811053446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collection_sources", force: :cascade do |t|
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "required"
    t.integer  "survey_id"
  end

  add_index "collection_sources", ["key"], name: "index_collection_sources_on_key", unique: true, using: :btree
  add_index "collection_sources", ["survey_id"], name: "index_collection_sources_on_survey_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.string   "imei"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "survey_id"
  end

  add_index "participants", ["survey_id"], name: "index_participants_on_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "name"
    t.text     "terms"
    t.boolean  "details_required"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "apk_file_name"
    t.string   "apk_content_type"
    t.integer  "apk_file_size"
    t.datetime "apk_updated_at"
  end

  create_table "users", force: :cascade do |t|
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "collection_sources", "surveys"
  add_foreign_key "participants", "surveys"
end
