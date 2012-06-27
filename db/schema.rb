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

ActiveRecord::Schema.define(:version => 20120626170025) do

  create_table "enterprises", :force => true do |t|
    t.integer  "parent_id",                        :default => 0
    t.integer  "user_id"
    t.string   "org_name"
    t.string   "uch_nomer_plat",     :limit => 9
    t.string   "vid_econom_deyatel"
    t.string   "organiz_pravo_form"
    t.string   "organ_upravlen"
    t.string   "edinic_izmer",       :limit => 20
    t.string   "adres"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "enterprises", ["parent_id", "id"], :name => "index_enterprises_on_parent_id_and_id"
  add_index "enterprises", ["parent_id"], :name => "index_enterprises_on_parent_id"
  add_index "enterprises", ["user_id"], :name => "index_enterprises_on_user_id"

  create_table "form_one_reports", :force => true do |t|
    t.integer  "enterprise_id"
    t.date     "date_period"
    t.integer  "S110",          :default => 0
    t.integer  "S120",          :default => 0
    t.integer  "S130",          :default => 0
    t.integer  "S131",          :default => 0
    t.integer  "S132",          :default => 0
    t.integer  "S133",          :default => 0
    t.integer  "S140",          :default => 0
    t.integer  "S150",          :default => 0
    t.integer  "S160",          :default => 0
    t.integer  "S170",          :default => 0
    t.integer  "S180",          :default => 0
    t.integer  "S190",          :default => 0
    t.integer  "S210",          :default => 0
    t.integer  "S211",          :default => 0
    t.integer  "S212",          :default => 0
    t.integer  "S213",          :default => 0
    t.integer  "S214",          :default => 0
    t.integer  "S215",          :default => 0
    t.integer  "S216",          :default => 0
    t.integer  "S220",          :default => 0
    t.integer  "S230",          :default => 0
    t.integer  "S240",          :default => 0
    t.integer  "S250",          :default => 0
    t.integer  "S260",          :default => 0
    t.integer  "S270",          :default => 0
    t.integer  "S280",          :default => 0
    t.integer  "S290",          :default => 0
    t.integer  "S300",          :default => 0
    t.integer  "S410",          :default => 0
    t.integer  "S420",          :default => 0
    t.integer  "S430",          :default => 0
    t.integer  "S440",          :default => 0
    t.integer  "S450",          :default => 0
    t.integer  "S460",          :default => 0
    t.integer  "S470",          :default => 0
    t.integer  "S480",          :default => 0
    t.integer  "S490",          :default => 0
    t.integer  "S510",          :default => 0
    t.integer  "S520",          :default => 0
    t.integer  "S530",          :default => 0
    t.integer  "S540",          :default => 0
    t.integer  "S550",          :default => 0
    t.integer  "S560",          :default => 0
    t.integer  "S590",          :default => 0
    t.integer  "S610",          :default => 0
    t.integer  "S620",          :default => 0
    t.integer  "S630",          :default => 0
    t.integer  "S631",          :default => 0
    t.integer  "S632",          :default => 0
    t.integer  "S633",          :default => 0
    t.integer  "S634",          :default => 0
    t.integer  "S635",          :default => 0
    t.integer  "S636",          :default => 0
    t.integer  "S637",          :default => 0
    t.integer  "S638",          :default => 0
    t.integer  "S640",          :default => 0
    t.integer  "S650",          :default => 0
    t.integer  "S660",          :default => 0
    t.integer  "S670",          :default => 0
    t.integer  "S690",          :default => 0
    t.integer  "S700",          :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "form_one_reports", ["enterprise_id", "date_period"], :name => "index_form_one_reports_on_enterprise_id_and_date_period"
  add_index "form_one_reports", ["enterprise_id"], :name => "index_form_one_reports_on_enterprise_id"

  create_table "form_three_reports", :force => true do |t|
    t.integer  "enterprise_id"
    t.date     "date_period_beg"
    t.date     "date_period_end"
    t.string   "G1"
    t.string   "G2"
    t.integer  "G3",              :default => 0
    t.integer  "G4",              :default => 0
    t.integer  "G5",              :default => 0
    t.integer  "G6",              :default => 0
    t.integer  "G7",              :default => 0
    t.integer  "G8",              :default => 0
    t.integer  "G9",              :default => 0
    t.integer  "G10",             :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "form_three_reports", ["enterprise_id", "date_period_beg", "G2"], :name => "three_enterpise_id_period_beg_G2"
  add_index "form_three_reports", ["enterprise_id", "date_period_beg", "date_period_end", "G2"], :name => "three_enterpise_id_period_G2"
  add_index "form_three_reports", ["enterprise_id", "date_period_end", "G2"], :name => "three_enterpise_id_period_end_G2"
  add_index "form_three_reports", ["enterprise_id"], :name => "index_form_three_reports_on_enterprise_id"

  create_table "form_two_reports", :force => true do |t|
    t.integer  "enterprise_id"
    t.date     "date_period_beg"
    t.date     "date_period_end"
    t.integer  "S010",            :default => 0
    t.integer  "S020",            :default => 0
    t.integer  "S030",            :default => 0
    t.integer  "S040",            :default => 0
    t.integer  "S050",            :default => 0
    t.integer  "S060",            :default => 0
    t.integer  "S070",            :default => 0
    t.integer  "S080",            :default => 0
    t.integer  "S090",            :default => 0
    t.integer  "S100",            :default => 0
    t.integer  "S101",            :default => 0
    t.integer  "S102",            :default => 0
    t.integer  "S103",            :default => 0
    t.integer  "S104",            :default => 0
    t.integer  "S110",            :default => 0
    t.integer  "S111",            :default => 0
    t.integer  "S112",            :default => 0
    t.integer  "S120",            :default => 0
    t.integer  "S121",            :default => 0
    t.integer  "S122",            :default => 0
    t.integer  "S130",            :default => 0
    t.integer  "S131",            :default => 0
    t.integer  "S132",            :default => 0
    t.integer  "S133",            :default => 0
    t.integer  "S140",            :default => 0
    t.integer  "S150",            :default => 0
    t.integer  "S160",            :default => 0
    t.integer  "S170",            :default => 0
    t.integer  "S180",            :default => 0
    t.integer  "S190",            :default => 0
    t.integer  "S200",            :default => 0
    t.integer  "S210",            :default => 0
    t.integer  "S211",            :default => 0
    t.integer  "S212",            :default => 0
    t.integer  "S213",            :default => 0
    t.integer  "S214",            :default => 0
    t.integer  "S220",            :default => 0
    t.integer  "S230",            :default => 0
    t.integer  "S240",            :default => 0
    t.integer  "S250",            :default => 0
    t.integer  "S260",            :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "form_two_reports", ["enterprise_id", "date_period_beg", "date_period_end", "id"], :name => "two_enterpise_id_period_id"
  add_index "form_two_reports", ["enterprise_id", "date_period_beg", "id"], :name => "two_enterpise_id_period_beg_id"
  add_index "form_two_reports", ["enterprise_id", "date_period_end", "id"], :name => "two_enterpise_id_period_end_id"
  add_index "form_two_reports", ["enterprise_id"], :name => "index_form_two_reports_on_enterprise_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
