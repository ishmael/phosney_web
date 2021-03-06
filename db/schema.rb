# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101123104749) do

  create_table "account_attributes", :force => true do |t|
    t.integer  "account_id",     :null => false
    t.integer  "attribute_type", :null => false
    t.string   "value",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.string   "bank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.integer  "balance_in_cents",   :limit => 8, :default => 0
    t.string   "currency"
    t.string   "color",                           :default => "#000000"
    t.integer  "overdraft_in_cents",              :default => 0
  end

  create_table "accounts_users", :force => true do |t|
    t.integer  "user_id",                                                                :null => false
    t.integer  "account_id",                                                             :null => false
    t.integer  "allow_delete", :limit => 1, :precision => 1, :scale => 0, :default => 0
    t.integer  "allow_edit",   :limit => 1, :precision => 1, :scale => 0, :default => 0
    t.integer  "allow_insert", :limit => 1, :precision => 1, :scale => 0, :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner",        :limit => 1, :precision => 1, :scale => 0, :default => 0
  end

  create_table "categories", :force => true do |t|
    t.string   "name",                                                                 :null => false
    t.integer  "user_id",                                                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id",                                             :default => 0
    t.integer  "mobile",     :limit => 1, :precision => 1, :scale => 0, :default => 0
  end

  add_index "categories", ["user_id", "name"], :name => "categories_name_ukey", :unique => true

  create_table "categories_users", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "category_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movements", :force => true do |t|
    t.integer  "account_id"
    t.string   "description"
    t.integer  "amount_in_cents", :limit => 8,                               :default => 0
    t.datetime "movdate"
    t.datetime "created_at"
    t.datetime "created_on"
    t.datetime "updated_at"
    t.datetime "updated_on"
    t.integer  "mov_type",        :limit => 1, :precision => 1, :scale => 0, :default => 1
    t.integer  "category_id"
    t.float    "lat"
    t.float    "lng"
    t.float    "accuracy"
    t.integer  "user_id",                                                                   :null => false
    t.integer  "private",         :limit => 1, :precision => 1, :scale => 0, :default => 0
    t.string   "currency"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shared_account_invitations", :force => true do |t|
    t.integer  "user_id",                                                                   :null => false
    t.string   "recipient_email"
    t.string   "token"
    t.integer  "account_id",                                                                :null => false
    t.integer  "allow_delete",    :limit => 1, :precision => 1, :scale => 0, :default => 0
    t.integer  "allow_edit",      :limit => 1, :precision => 1, :scale => 0, :default => 0
    t.integer  "allow_insert",    :limit => 1, :precision => 1, :scale => 0, :default => 1
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "user_id", :null => false
  end

  add_index "tags", ["user_id", "name"], :name => "tags_name_ukey", :unique => true

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale"
  end

  add_index "users", ["login"], :name => "users_login_ukey", :unique => true

end
