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

ActiveRecord::Schema.define(:version => 20120726090344) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "p_id"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "logins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "action"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "source_id"
  end

  create_table "subscribe_groups", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "subscribe_groups", ["user_id"], :name => "index_subscribe_groups_on_user_id"

  create_table "subscribe_groups_members", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "subscribe_group_id"
  end

  create_table "user_closed_posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "post_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_closed_posts", ["post_id"], :name => "index_user_closed_posts_on_post_id"
  add_index "user_closed_posts", ["user_id"], :name => "index_user_closed_posts_on_user_id"

  create_table "user_favorites", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "post_id"
  end

  add_index "user_favorites", ["post_id"], :name => "index_user_favorites_on_post_id"
  add_index "user_favorites", ["user_id"], :name => "index_user_favorites_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "pwd"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image_url"
  end

end
