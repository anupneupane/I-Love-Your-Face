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

ActiveRecord::Schema.define(:version => 20130612135140) do

  create_table "messages", :force => true do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.text     "body"
    t.boolean  "read"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "messages", ["recipient_id"], :name => "index_messages_on_recipient_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "single_person"
    t.boolean  "approved"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "is_user"
    t.integer  "photo_age"
    t.string   "photo_type"
    t.boolean  "is_profile_pic"
  end

  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "type_matches", :force => true do |t|
    t.integer "user_id"
    t.integer "type_id"
  end

  add_index "type_matches", ["type_id"], :name => "index_type_matches_on_type_id"
  add_index "type_matches", ["user_id"], :name => "index_type_matches_on_user_id"

  create_table "type_photos", :force => true do |t|
    t.integer "type_id"
    t.integer "photo_id"
  end

  add_index "type_photos", ["photo_id"], :name => "index_type_photos_on_photo_id"
  add_index "type_photos", ["type_id"], :name => "index_type_photos_on_type_id"

  create_table "types", :force => true do |t|
    t.integer "user_id"
  end

  add_index "types", ["user_id"], :name => "index_types_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "username",               :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "visits", :force => true do |t|
    t.integer  "visitor_id"
    t.integer  "visitee_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "visits", ["visitee_id"], :name => "index_visits_on_visitee_id"
  add_index "visits", ["visitor_id"], :name => "index_visits_on_visitor_id"

end
