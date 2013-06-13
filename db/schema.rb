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

ActiveRecord::Schema.define(:version => 20130613191743) do

  create_table "feedbacks", :force => true do |t|
    t.integer  "feedback_giver_id"
    t.integer  "feedback_receiver_id"
    t.text     "body"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.boolean  "read"
  end

  add_index "feedbacks", ["feedback_giver_id"], :name => "index_feedbacks_on_feedback_giver_id"
  add_index "feedbacks", ["feedback_receiver_id"], :name => "index_feedbacks_on_feedback_receiver_id"

  create_table "likings", :force => true do |t|
    t.integer  "liking_user_id"
    t.integer  "liked_user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "likings", ["liked_user_id"], :name => "index_likings_on_liked_user_id"
  add_index "likings", ["liking_user_id"], :name => "index_likings_on_liking_user_id"

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

  create_table "ratings", :force => true do |t|
    t.integer  "rating_giver_id"
    t.integer  "rating_receiver_id"
    t.integer  "score"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "ratings", ["rating_giver_id"], :name => "index_ratings_on_rating_giver_id"
  add_index "ratings", ["rating_receiver_id"], :name => "index_ratings_on_rating_receiver_id"

  create_table "shunnings", :force => true do |t|
    t.integer  "shunning_user_id"
    t.integer  "shunned_user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "shunnings", ["shunned_user_id"], :name => "index_shunnings_on_shunned_user_id"
  add_index "shunnings", ["shunning_user_id"], :name => "index_shunnings_on_shunning_user_id"

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
    t.string   "email",                  :default => "",           :null => false
    t.string   "encrypted_password",     :default => "",           :null => false
    t.string   "username",               :default => "",           :null => false
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
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "num_likes",              :default => 5
    t.date     "last_like_refresh",      :default => '2013-06-13'
    t.integer  "age"
    t.string   "sex"
    t.integer  "zipcode"
    t.integer  "height"
    t.integer  "weight"
    t.string   "relationship_status"
    t.string   "ethnicity"
    t.string   "body_type"
    t.string   "orientation"
    t.text     "about_me"
    t.text     "about_my_match"
    t.text     "dealbreakers"
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
