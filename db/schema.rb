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

ActiveRecord::Schema.define(:version => 20120825141210) do

  create_table "analytical_balances", :force => true do |t|
    t.integer  "enterprise_id"
    t.date     "date_period_beg"
    t.date     "date_period_end"
    t.integer  "row_type",                                      :default => 0
    t.string   "G1",                                            :default => ""
    t.string   "G2",                                            :default => ""
    t.integer  "G3",                                            :default => 0
    t.decimal  "G4",              :precision => 7, :scale => 2, :default => 0.0
    t.integer  "G5",                                            :default => 0
    t.decimal  "G6",              :precision => 7, :scale => 2, :default => 0.0
    t.integer  "G7",                                            :default => 0
    t.decimal  "G8",              :precision => 7, :scale => 2, :default => 0.0
    t.decimal  "G9",              :precision => 7, :scale => 2, :default => 0.0
    t.decimal  "G10",             :precision => 7, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "analytical_balances", ["enterprise_id", "date_period_beg", "date_period_end"], :name => "ab_enterpise_id_period"
  add_index "analytical_balances", ["enterprise_id", "date_period_beg"], :name => "ab_enterpise_id_period_beg"
  add_index "analytical_balances", ["enterprise_id", "date_period_end"], :name => "ab_enterpise_id_period_end"
  add_index "analytical_balances", ["enterprise_id"], :name => "index_analytical_balances_on_enterprise_id"

  create_table "balanse_rows", :force => true do |t|
    t.integer  "enterprise_id"
    t.integer  "diag_type",                                     :default => 0
    t.date     "date_period_beg"
    t.date     "date_period_end"
    t.string   "name",                                          :default => ""
    t.integer  "summa",                                         :default => 0
    t.decimal  "summa_dec",       :precision => 6, :scale => 4, :default => 0.0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "balanse_rows", ["enterprise_id", "date_period_beg", "date_period_end"], :name => "br_enterpise_id_period"
  add_index "balanse_rows", ["enterprise_id", "date_period_beg"], :name => "br_enterpise_id_period_beg"
  add_index "balanse_rows", ["enterprise_id", "date_period_end"], :name => "br_enterpise_id_period_end"
  add_index "balanse_rows", ["enterprise_id"], :name => "index_balanse_rows_on_enterprise_id"

  create_table "balanse_values", :force => true do |t|
    t.integer  "balanse_row_id"
    t.date     "date_period"
    t.integer  "summa",                                        :default => 0
    t.decimal  "summa_dec",      :precision => 6, :scale => 4, :default => 0.0
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
  end

  add_index "balanse_values", ["balanse_row_id"], :name => "index_balanse_values_on_balanse_row_id"

  create_table "enterprises", :force => true do |t|
    t.integer  "parent_id",                                                      :default => 0
    t.integer  "user_id"
    t.string   "org_name"
    t.string   "uch_nomer_plat",     :limit => 9
    t.string   "vid_econom_deyatel"
    t.string   "organiz_pravo_form"
    t.string   "organ_upravlen"
    t.string   "edinic_izmer",       :limit => 20
    t.string   "adres"
    t.decimal  "K1",                               :precision => 3, :scale => 2, :default => 0.0
    t.decimal  "K2",                               :precision => 3, :scale => 2, :default => 0.0
    t.decimal  "K3",                               :precision => 3, :scale => 2, :default => 0.0
    t.date     "rab_date_beg"
    t.date     "rab_date_end"
    t.datetime "created_at",                                                                      :null => false
    t.datetime "updated_at",                                                                      :null => false
  end

  add_index "enterprises", ["parent_id", "id"], :name => "index_enterprises_on_parent_id_and_id"
  add_index "enterprises", ["parent_id"], :name => "index_enterprises_on_parent_id"
  add_index "enterprises", ["user_id"], :name => "index_enterprises_on_user_id"

  create_table "form_four_reports", :force => true do |t|
    t.integer  "enterprise_id"
    t.date     "date_period_beg"
    t.date     "date_period_end"
    t.integer  "S020",            :default => 0
    t.integer  "S021",            :default => 0
    t.integer  "S022",            :default => 0
    t.integer  "S023",            :default => 0
    t.integer  "S024",            :default => 0
    t.integer  "S030",            :default => 0
    t.integer  "S031",            :default => 0
    t.integer  "S032",            :default => 0
    t.integer  "S033",            :default => 0
    t.integer  "S034",            :default => 0
    t.integer  "S040",            :default => 0
    t.integer  "S050",            :default => 0
    t.integer  "S051",            :default => 0
    t.integer  "S052",            :default => 0
    t.integer  "S053",            :default => 0
    t.integer  "S054",            :default => 0
    t.integer  "S055",            :default => 0
    t.integer  "S060",            :default => 0
    t.integer  "S061",            :default => 0
    t.integer  "S062",            :default => 0
    t.integer  "S063",            :default => 0
    t.integer  "S064",            :default => 0
    t.integer  "S070",            :default => 0
    t.integer  "S080",            :default => 0
    t.integer  "S081",            :default => 0
    t.integer  "S082",            :default => 0
    t.integer  "S083",            :default => 0
    t.integer  "S084",            :default => 0
    t.integer  "S090",            :default => 0
    t.integer  "S091",            :default => 0
    t.integer  "S092",            :default => 0
    t.integer  "S093",            :default => 0
    t.integer  "S094",            :default => 0
    t.integer  "S095",            :default => 0
    t.integer  "S100",            :default => 0
    t.integer  "S110",            :default => 0
    t.integer  "S120",            :default => 0
    t.integer  "S130",            :default => 0
    t.integer  "S140",            :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "form_four_reports", ["enterprise_id", "date_period_beg", "date_period_end"], :name => "four_enterpise_id_period"
  add_index "form_four_reports", ["enterprise_id", "date_period_beg"], :name => "four_enterpise_id_period_beg"
  add_index "form_four_reports", ["enterprise_id", "date_period_end"], :name => "four_enterpise_id_period_end"
  add_index "form_four_reports", ["enterprise_id"], :name => "index_form_four_reports_on_enterprise_id"

  create_table "form_one_reports", :force => true do |t|
    t.integer  "enterprise_id"
    t.date     "date_period"
    t.integer  "S110",                                        :default => 0
    t.integer  "S120",                                        :default => 0
    t.integer  "S130",                                        :default => 0
    t.integer  "S131",                                        :default => 0
    t.integer  "S132",                                        :default => 0
    t.integer  "S133",                                        :default => 0
    t.integer  "S140",                                        :default => 0
    t.integer  "S150",                                        :default => 0
    t.integer  "S160",                                        :default => 0
    t.integer  "S170",                                        :default => 0
    t.integer  "S180",                                        :default => 0
    t.integer  "S190",                                        :default => 0
    t.integer  "S210",                                        :default => 0
    t.integer  "S211",                                        :default => 0
    t.integer  "S212",                                        :default => 0
    t.integer  "S213",                                        :default => 0
    t.integer  "S214",                                        :default => 0
    t.integer  "S215",                                        :default => 0
    t.integer  "S216",                                        :default => 0
    t.integer  "S220",                                        :default => 0
    t.integer  "S230",                                        :default => 0
    t.integer  "S240",                                        :default => 0
    t.integer  "S250",                                        :default => 0
    t.integer  "S260",                                        :default => 0
    t.integer  "S270",                                        :default => 0
    t.integer  "S280",                                        :default => 0
    t.integer  "S290",                                        :default => 0
    t.integer  "S300",                                        :default => 0
    t.integer  "S410",                                        :default => 0
    t.integer  "S420",                                        :default => 0
    t.integer  "S430",                                        :default => 0
    t.integer  "S440",                                        :default => 0
    t.integer  "S450",                                        :default => 0
    t.integer  "S460",                                        :default => 0
    t.integer  "S470",                                        :default => 0
    t.integer  "S480",                                        :default => 0
    t.integer  "S490",                                        :default => 0
    t.integer  "S510",                                        :default => 0
    t.integer  "S520",                                        :default => 0
    t.integer  "S530",                                        :default => 0
    t.integer  "S540",                                        :default => 0
    t.integer  "S550",                                        :default => 0
    t.integer  "S560",                                        :default => 0
    t.integer  "S590",                                        :default => 0
    t.integer  "S610",                                        :default => 0
    t.integer  "S620",                                        :default => 0
    t.integer  "S630",                                        :default => 0
    t.integer  "S631",                                        :default => 0
    t.integer  "S632",                                        :default => 0
    t.integer  "S633",                                        :default => 0
    t.integer  "S634",                                        :default => 0
    t.integer  "S635",                                        :default => 0
    t.integer  "S636",                                        :default => 0
    t.integer  "S637",                                        :default => 0
    t.integer  "S638",                                        :default => 0
    t.integer  "S640",                                        :default => 0
    t.integer  "S650",                                        :default => 0
    t.integer  "S660",                                        :default => 0
    t.integer  "S670",                                        :default => 0
    t.integer  "S690",                                        :default => 0
    t.integer  "S700",                                        :default => 0
    t.decimal  "Kfnez",         :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kfzav",         :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kdfnez",        :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kcap",          :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kman",          :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "K1",            :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kabsl",         :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kkrl",          :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "K2",            :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "K3",            :precision => 6, :scale => 4, :default => 0.0
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  add_index "form_one_reports", ["enterprise_id", "date_period"], :name => "index_form_one_reports_on_enterprise_id_and_date_period"
  add_index "form_one_reports", ["enterprise_id"], :name => "index_form_one_reports_on_enterprise_id"

  create_table "form_three_reports", :force => true do |t|
    t.integer  "enterprise_id"
    t.date     "date_period_beg"
    t.date     "date_period_end"
    t.integer  "G3_S010",         :default => 0
    t.integer  "G4_S010",         :default => 0
    t.integer  "G5_S010",         :default => 0
    t.integer  "G6_S010",         :default => 0
    t.integer  "G7_S010",         :default => 0
    t.integer  "G8_S010",         :default => 0
    t.integer  "G9_S010",         :default => 0
    t.integer  "G10_S010",        :default => 0
    t.integer  "G3_S020",         :default => 0
    t.integer  "G4_S020",         :default => 0
    t.integer  "G5_S020",         :default => 0
    t.integer  "G6_S020",         :default => 0
    t.integer  "G7_S020",         :default => 0
    t.integer  "G8_S020",         :default => 0
    t.integer  "G9_S020",         :default => 0
    t.integer  "G10_S020",        :default => 0
    t.integer  "G3_S030",         :default => 0
    t.integer  "G4_S030",         :default => 0
    t.integer  "G5_S030",         :default => 0
    t.integer  "G6_S030",         :default => 0
    t.integer  "G7_S030",         :default => 0
    t.integer  "G8_S030",         :default => 0
    t.integer  "G9_S030",         :default => 0
    t.integer  "G10_S030",        :default => 0
    t.integer  "G3_S040",         :default => 0
    t.integer  "G4_S040",         :default => 0
    t.integer  "G5_S040",         :default => 0
    t.integer  "G6_S040",         :default => 0
    t.integer  "G7_S040",         :default => 0
    t.integer  "G8_S040",         :default => 0
    t.integer  "G9_S040",         :default => 0
    t.integer  "G10_S040",        :default => 0
    t.integer  "G3_S050",         :default => 0
    t.integer  "G4_S050",         :default => 0
    t.integer  "G5_S050",         :default => 0
    t.integer  "G6_S050",         :default => 0
    t.integer  "G7_S050",         :default => 0
    t.integer  "G8_S050",         :default => 0
    t.integer  "G9_S050",         :default => 0
    t.integer  "G10_S050",        :default => 0
    t.integer  "G3_S051",         :default => 0
    t.integer  "G4_S051",         :default => 0
    t.integer  "G5_S051",         :default => 0
    t.integer  "G6_S051",         :default => 0
    t.integer  "G7_S051",         :default => 0
    t.integer  "G8_S051",         :default => 0
    t.integer  "G9_S051",         :default => 0
    t.integer  "G10_S051",        :default => 0
    t.integer  "G3_S052",         :default => 0
    t.integer  "G4_S052",         :default => 0
    t.integer  "G5_S052",         :default => 0
    t.integer  "G6_S052",         :default => 0
    t.integer  "G7_S052",         :default => 0
    t.integer  "G8_S052",         :default => 0
    t.integer  "G9_S052",         :default => 0
    t.integer  "G10_S052",        :default => 0
    t.integer  "G3_S053",         :default => 0
    t.integer  "G4_S053",         :default => 0
    t.integer  "G5_S053",         :default => 0
    t.integer  "G6_S053",         :default => 0
    t.integer  "G7_S053",         :default => 0
    t.integer  "G8_S053",         :default => 0
    t.integer  "G9_S053",         :default => 0
    t.integer  "G10_S053",        :default => 0
    t.integer  "G3_S054",         :default => 0
    t.integer  "G4_S054",         :default => 0
    t.integer  "G5_S054",         :default => 0
    t.integer  "G6_S054",         :default => 0
    t.integer  "G7_S054",         :default => 0
    t.integer  "G8_S054",         :default => 0
    t.integer  "G9_S054",         :default => 0
    t.integer  "G10_S054",        :default => 0
    t.integer  "G3_S055",         :default => 0
    t.integer  "G4_S055",         :default => 0
    t.integer  "G5_S055",         :default => 0
    t.integer  "G6_S055",         :default => 0
    t.integer  "G7_S055",         :default => 0
    t.integer  "G8_S055",         :default => 0
    t.integer  "G9_S055",         :default => 0
    t.integer  "G10_S055",        :default => 0
    t.integer  "G3_S056",         :default => 0
    t.integer  "G4_S056",         :default => 0
    t.integer  "G5_S056",         :default => 0
    t.integer  "G6_S056",         :default => 0
    t.integer  "G7_S056",         :default => 0
    t.integer  "G8_S056",         :default => 0
    t.integer  "G9_S056",         :default => 0
    t.integer  "G10_S056",        :default => 0
    t.integer  "G3_S057",         :default => 0
    t.integer  "G4_S057",         :default => 0
    t.integer  "G5_S057",         :default => 0
    t.integer  "G6_S057",         :default => 0
    t.integer  "G7_S057",         :default => 0
    t.integer  "G8_S057",         :default => 0
    t.integer  "G9_S057",         :default => 0
    t.integer  "G10_S057",        :default => 0
    t.integer  "G3_S058",         :default => 0
    t.integer  "G4_S058",         :default => 0
    t.integer  "G5_S058",         :default => 0
    t.integer  "G6_S058",         :default => 0
    t.integer  "G7_S058",         :default => 0
    t.integer  "G8_S058",         :default => 0
    t.integer  "G9_S058",         :default => 0
    t.integer  "G10_S058",        :default => 0
    t.integer  "G3_S059",         :default => 0
    t.integer  "G4_S059",         :default => 0
    t.integer  "G5_S059",         :default => 0
    t.integer  "G6_S059",         :default => 0
    t.integer  "G7_S059",         :default => 0
    t.integer  "G8_S059",         :default => 0
    t.integer  "G9_S059",         :default => 0
    t.integer  "G10_S059",        :default => 0
    t.integer  "G3_S060",         :default => 0
    t.integer  "G4_S060",         :default => 0
    t.integer  "G5_S060",         :default => 0
    t.integer  "G6_S060",         :default => 0
    t.integer  "G7_S060",         :default => 0
    t.integer  "G8_S060",         :default => 0
    t.integer  "G9_S060",         :default => 0
    t.integer  "G10_S060",        :default => 0
    t.integer  "G3_S061",         :default => 0
    t.integer  "G4_S061",         :default => 0
    t.integer  "G5_S061",         :default => 0
    t.integer  "G6_S061",         :default => 0
    t.integer  "G7_S061",         :default => 0
    t.integer  "G8_S061",         :default => 0
    t.integer  "G9_S061",         :default => 0
    t.integer  "G10_S061",        :default => 0
    t.integer  "G3_S062",         :default => 0
    t.integer  "G4_S062",         :default => 0
    t.integer  "G5_S062",         :default => 0
    t.integer  "G6_S062",         :default => 0
    t.integer  "G7_S062",         :default => 0
    t.integer  "G8_S062",         :default => 0
    t.integer  "G9_S062",         :default => 0
    t.integer  "G10_S062",        :default => 0
    t.integer  "G3_S063",         :default => 0
    t.integer  "G4_S063",         :default => 0
    t.integer  "G5_S063",         :default => 0
    t.integer  "G6_S063",         :default => 0
    t.integer  "G7_S063",         :default => 0
    t.integer  "G8_S063",         :default => 0
    t.integer  "G9_S063",         :default => 0
    t.integer  "G10_S063",        :default => 0
    t.integer  "G3_S064",         :default => 0
    t.integer  "G4_S064",         :default => 0
    t.integer  "G5_S064",         :default => 0
    t.integer  "G6_S064",         :default => 0
    t.integer  "G7_S064",         :default => 0
    t.integer  "G8_S064",         :default => 0
    t.integer  "G9_S064",         :default => 0
    t.integer  "G10_S064",        :default => 0
    t.integer  "G3_S065",         :default => 0
    t.integer  "G4_S065",         :default => 0
    t.integer  "G5_S065",         :default => 0
    t.integer  "G6_S065",         :default => 0
    t.integer  "G7_S065",         :default => 0
    t.integer  "G8_S065",         :default => 0
    t.integer  "G9_S065",         :default => 0
    t.integer  "G10_S065",        :default => 0
    t.integer  "G3_S066",         :default => 0
    t.integer  "G4_S066",         :default => 0
    t.integer  "G5_S066",         :default => 0
    t.integer  "G6_S066",         :default => 0
    t.integer  "G7_S066",         :default => 0
    t.integer  "G8_S066",         :default => 0
    t.integer  "G9_S066",         :default => 0
    t.integer  "G10_S066",        :default => 0
    t.integer  "G3_S067",         :default => 0
    t.integer  "G4_S067",         :default => 0
    t.integer  "G5_S067",         :default => 0
    t.integer  "G6_S067",         :default => 0
    t.integer  "G7_S067",         :default => 0
    t.integer  "G8_S067",         :default => 0
    t.integer  "G9_S067",         :default => 0
    t.integer  "G10_S067",        :default => 0
    t.integer  "G3_S068",         :default => 0
    t.integer  "G4_S068",         :default => 0
    t.integer  "G5_S068",         :default => 0
    t.integer  "G6_S068",         :default => 0
    t.integer  "G7_S068",         :default => 0
    t.integer  "G8_S068",         :default => 0
    t.integer  "G9_S068",         :default => 0
    t.integer  "G10_S068",        :default => 0
    t.integer  "G3_S069",         :default => 0
    t.integer  "G4_S069",         :default => 0
    t.integer  "G5_S069",         :default => 0
    t.integer  "G6_S069",         :default => 0
    t.integer  "G7_S069",         :default => 0
    t.integer  "G8_S069",         :default => 0
    t.integer  "G9_S069",         :default => 0
    t.integer  "G10_S069",        :default => 0
    t.integer  "G3_S070",         :default => 0
    t.integer  "G4_S070",         :default => 0
    t.integer  "G5_S070",         :default => 0
    t.integer  "G6_S070",         :default => 0
    t.integer  "G7_S070",         :default => 0
    t.integer  "G8_S070",         :default => 0
    t.integer  "G9_S070",         :default => 0
    t.integer  "G10_S070",        :default => 0
    t.integer  "G3_S080",         :default => 0
    t.integer  "G4_S080",         :default => 0
    t.integer  "G5_S080",         :default => 0
    t.integer  "G6_S080",         :default => 0
    t.integer  "G7_S080",         :default => 0
    t.integer  "G8_S080",         :default => 0
    t.integer  "G9_S080",         :default => 0
    t.integer  "G10_S080",        :default => 0
    t.integer  "G3_S090",         :default => 0
    t.integer  "G4_S090",         :default => 0
    t.integer  "G5_S090",         :default => 0
    t.integer  "G6_S090",         :default => 0
    t.integer  "G7_S090",         :default => 0
    t.integer  "G8_S090",         :default => 0
    t.integer  "G9_S090",         :default => 0
    t.integer  "G10_S090",        :default => 0
    t.integer  "G3_S100",         :default => 0
    t.integer  "G4_S100",         :default => 0
    t.integer  "G5_S100",         :default => 0
    t.integer  "G6_S100",         :default => 0
    t.integer  "G7_S100",         :default => 0
    t.integer  "G8_S100",         :default => 0
    t.integer  "G9_S100",         :default => 0
    t.integer  "G10_S100",        :default => 0
    t.integer  "G3_S110",         :default => 0
    t.integer  "G4_S110",         :default => 0
    t.integer  "G5_S110",         :default => 0
    t.integer  "G6_S110",         :default => 0
    t.integer  "G7_S110",         :default => 0
    t.integer  "G8_S110",         :default => 0
    t.integer  "G9_S110",         :default => 0
    t.integer  "G10_S110",        :default => 0
    t.integer  "G3_S120",         :default => 0
    t.integer  "G4_S120",         :default => 0
    t.integer  "G5_S120",         :default => 0
    t.integer  "G6_S120",         :default => 0
    t.integer  "G7_S120",         :default => 0
    t.integer  "G8_S120",         :default => 0
    t.integer  "G9_S120",         :default => 0
    t.integer  "G10_S120",        :default => 0
    t.integer  "G3_S130",         :default => 0
    t.integer  "G4_S130",         :default => 0
    t.integer  "G5_S130",         :default => 0
    t.integer  "G6_S130",         :default => 0
    t.integer  "G7_S130",         :default => 0
    t.integer  "G8_S130",         :default => 0
    t.integer  "G9_S130",         :default => 0
    t.integer  "G10_S130",        :default => 0
    t.integer  "G3_S140",         :default => 0
    t.integer  "G4_S140",         :default => 0
    t.integer  "G5_S140",         :default => 0
    t.integer  "G6_S140",         :default => 0
    t.integer  "G7_S140",         :default => 0
    t.integer  "G8_S140",         :default => 0
    t.integer  "G9_S140",         :default => 0
    t.integer  "G10_S140",        :default => 0
    t.integer  "G3_S150",         :default => 0
    t.integer  "G4_S150",         :default => 0
    t.integer  "G5_S150",         :default => 0
    t.integer  "G6_S150",         :default => 0
    t.integer  "G7_S150",         :default => 0
    t.integer  "G8_S150",         :default => 0
    t.integer  "G9_S150",         :default => 0
    t.integer  "G10_S150",        :default => 0
    t.integer  "G3_S151",         :default => 0
    t.integer  "G4_S151",         :default => 0
    t.integer  "G5_S151",         :default => 0
    t.integer  "G6_S151",         :default => 0
    t.integer  "G7_S151",         :default => 0
    t.integer  "G8_S151",         :default => 0
    t.integer  "G9_S151",         :default => 0
    t.integer  "G10_S151",        :default => 0
    t.integer  "G3_S152",         :default => 0
    t.integer  "G4_S152",         :default => 0
    t.integer  "G5_S152",         :default => 0
    t.integer  "G6_S152",         :default => 0
    t.integer  "G7_S152",         :default => 0
    t.integer  "G8_S152",         :default => 0
    t.integer  "G9_S152",         :default => 0
    t.integer  "G10_S152",        :default => 0
    t.integer  "G3_S153",         :default => 0
    t.integer  "G4_S153",         :default => 0
    t.integer  "G5_S153",         :default => 0
    t.integer  "G6_S153",         :default => 0
    t.integer  "G7_S153",         :default => 0
    t.integer  "G8_S153",         :default => 0
    t.integer  "G9_S153",         :default => 0
    t.integer  "G10_S153",        :default => 0
    t.integer  "G3_S154",         :default => 0
    t.integer  "G4_S154",         :default => 0
    t.integer  "G5_S154",         :default => 0
    t.integer  "G6_S154",         :default => 0
    t.integer  "G7_S154",         :default => 0
    t.integer  "G8_S154",         :default => 0
    t.integer  "G9_S154",         :default => 0
    t.integer  "G10_S154",        :default => 0
    t.integer  "G3_S155",         :default => 0
    t.integer  "G4_S155",         :default => 0
    t.integer  "G5_S155",         :default => 0
    t.integer  "G6_S155",         :default => 0
    t.integer  "G7_S155",         :default => 0
    t.integer  "G8_S155",         :default => 0
    t.integer  "G9_S155",         :default => 0
    t.integer  "G10_S155",        :default => 0
    t.integer  "G3_S156",         :default => 0
    t.integer  "G4_S156",         :default => 0
    t.integer  "G5_S156",         :default => 0
    t.integer  "G6_S156",         :default => 0
    t.integer  "G7_S156",         :default => 0
    t.integer  "G8_S156",         :default => 0
    t.integer  "G9_S156",         :default => 0
    t.integer  "G10_S156",        :default => 0
    t.integer  "G3_S157",         :default => 0
    t.integer  "G4_S157",         :default => 0
    t.integer  "G5_S157",         :default => 0
    t.integer  "G6_S157",         :default => 0
    t.integer  "G7_S157",         :default => 0
    t.integer  "G8_S157",         :default => 0
    t.integer  "G9_S157",         :default => 0
    t.integer  "G10_S157",        :default => 0
    t.integer  "G3_S158",         :default => 0
    t.integer  "G4_S158",         :default => 0
    t.integer  "G5_S158",         :default => 0
    t.integer  "G6_S158",         :default => 0
    t.integer  "G7_S158",         :default => 0
    t.integer  "G8_S158",         :default => 0
    t.integer  "G9_S158",         :default => 0
    t.integer  "G10_S158",        :default => 0
    t.integer  "G3_S159",         :default => 0
    t.integer  "G4_S159",         :default => 0
    t.integer  "G5_S159",         :default => 0
    t.integer  "G6_S159",         :default => 0
    t.integer  "G7_S159",         :default => 0
    t.integer  "G8_S159",         :default => 0
    t.integer  "G9_S159",         :default => 0
    t.integer  "G10_S159",        :default => 0
    t.integer  "G3_S160",         :default => 0
    t.integer  "G4_S160",         :default => 0
    t.integer  "G5_S160",         :default => 0
    t.integer  "G6_S160",         :default => 0
    t.integer  "G7_S160",         :default => 0
    t.integer  "G8_S160",         :default => 0
    t.integer  "G9_S160",         :default => 0
    t.integer  "G10_S160",        :default => 0
    t.integer  "G3_S161",         :default => 0
    t.integer  "G4_S161",         :default => 0
    t.integer  "G5_S161",         :default => 0
    t.integer  "G6_S161",         :default => 0
    t.integer  "G7_S161",         :default => 0
    t.integer  "G8_S161",         :default => 0
    t.integer  "G9_S161",         :default => 0
    t.integer  "G10_S161",        :default => 0
    t.integer  "G3_S162",         :default => 0
    t.integer  "G4_S162",         :default => 0
    t.integer  "G5_S162",         :default => 0
    t.integer  "G6_S162",         :default => 0
    t.integer  "G7_S162",         :default => 0
    t.integer  "G8_S162",         :default => 0
    t.integer  "G9_S162",         :default => 0
    t.integer  "G10_S162",        :default => 0
    t.integer  "G3_S163",         :default => 0
    t.integer  "G4_S163",         :default => 0
    t.integer  "G5_S163",         :default => 0
    t.integer  "G6_S163",         :default => 0
    t.integer  "G7_S163",         :default => 0
    t.integer  "G8_S163",         :default => 0
    t.integer  "G9_S163",         :default => 0
    t.integer  "G10_S163",        :default => 0
    t.integer  "G3_S164",         :default => 0
    t.integer  "G4_S164",         :default => 0
    t.integer  "G5_S164",         :default => 0
    t.integer  "G6_S164",         :default => 0
    t.integer  "G7_S164",         :default => 0
    t.integer  "G8_S164",         :default => 0
    t.integer  "G9_S164",         :default => 0
    t.integer  "G10_S164",        :default => 0
    t.integer  "G3_S165",         :default => 0
    t.integer  "G4_S165",         :default => 0
    t.integer  "G5_S165",         :default => 0
    t.integer  "G6_S165",         :default => 0
    t.integer  "G7_S165",         :default => 0
    t.integer  "G8_S165",         :default => 0
    t.integer  "G9_S165",         :default => 0
    t.integer  "G10_S165",        :default => 0
    t.integer  "G3_S166",         :default => 0
    t.integer  "G4_S166",         :default => 0
    t.integer  "G5_S166",         :default => 0
    t.integer  "G6_S166",         :default => 0
    t.integer  "G7_S166",         :default => 0
    t.integer  "G8_S166",         :default => 0
    t.integer  "G9_S166",         :default => 0
    t.integer  "G10_S166",        :default => 0
    t.integer  "G3_S167",         :default => 0
    t.integer  "G4_S167",         :default => 0
    t.integer  "G5_S167",         :default => 0
    t.integer  "G6_S167",         :default => 0
    t.integer  "G7_S167",         :default => 0
    t.integer  "G8_S167",         :default => 0
    t.integer  "G9_S167",         :default => 0
    t.integer  "G10_S167",        :default => 0
    t.integer  "G3_S168",         :default => 0
    t.integer  "G4_S168",         :default => 0
    t.integer  "G5_S168",         :default => 0
    t.integer  "G6_S168",         :default => 0
    t.integer  "G7_S168",         :default => 0
    t.integer  "G8_S168",         :default => 0
    t.integer  "G9_S168",         :default => 0
    t.integer  "G10_S168",        :default => 0
    t.integer  "G3_S169",         :default => 0
    t.integer  "G4_S169",         :default => 0
    t.integer  "G5_S169",         :default => 0
    t.integer  "G6_S169",         :default => 0
    t.integer  "G7_S169",         :default => 0
    t.integer  "G8_S169",         :default => 0
    t.integer  "G9_S169",         :default => 0
    t.integer  "G10_S169",        :default => 0
    t.integer  "G3_S170",         :default => 0
    t.integer  "G4_S170",         :default => 0
    t.integer  "G5_S170",         :default => 0
    t.integer  "G6_S170",         :default => 0
    t.integer  "G7_S170",         :default => 0
    t.integer  "G8_S170",         :default => 0
    t.integer  "G9_S170",         :default => 0
    t.integer  "G10_S170",        :default => 0
    t.integer  "G3_S180",         :default => 0
    t.integer  "G4_S180",         :default => 0
    t.integer  "G5_S180",         :default => 0
    t.integer  "G6_S180",         :default => 0
    t.integer  "G7_S180",         :default => 0
    t.integer  "G8_S180",         :default => 0
    t.integer  "G9_S180",         :default => 0
    t.integer  "G10_S180",        :default => 0
    t.integer  "G3_S190",         :default => 0
    t.integer  "G4_S190",         :default => 0
    t.integer  "G5_S190",         :default => 0
    t.integer  "G6_S190",         :default => 0
    t.integer  "G7_S190",         :default => 0
    t.integer  "G8_S190",         :default => 0
    t.integer  "G9_S190",         :default => 0
    t.integer  "G10_S190",        :default => 0
    t.integer  "G3_S200",         :default => 0
    t.integer  "G4_S200",         :default => 0
    t.integer  "G5_S200",         :default => 0
    t.integer  "G6_S200",         :default => 0
    t.integer  "G7_S200",         :default => 0
    t.integer  "G8_S200",         :default => 0
    t.integer  "G9_S200",         :default => 0
    t.integer  "G10_S200",        :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "form_three_reports", ["enterprise_id", "date_period_beg", "date_period_end"], :name => "three_enterpise_id_period"
  add_index "form_three_reports", ["enterprise_id", "date_period_beg"], :name => "three_enterpise_id_period_beg"
  add_index "form_three_reports", ["enterprise_id", "date_period_end"], :name => "three_enterpise_id_period_end"
  add_index "form_three_reports", ["enterprise_id"], :name => "index_form_three_reports_on_enterprise_id"

  create_table "form_two_reports", :force => true do |t|
    t.integer  "enterprise_id"
    t.date     "date_period_beg"
    t.date     "date_period_end"
    t.integer  "S010",                                          :default => 0
    t.integer  "S020",                                          :default => 0
    t.integer  "S030",                                          :default => 0
    t.integer  "S040",                                          :default => 0
    t.integer  "S050",                                          :default => 0
    t.integer  "S060",                                          :default => 0
    t.integer  "S070",                                          :default => 0
    t.integer  "S080",                                          :default => 0
    t.integer  "S090",                                          :default => 0
    t.integer  "S100",                                          :default => 0
    t.integer  "S101",                                          :default => 0
    t.integer  "S102",                                          :default => 0
    t.integer  "S103",                                          :default => 0
    t.integer  "S104",                                          :default => 0
    t.integer  "S110",                                          :default => 0
    t.integer  "S111",                                          :default => 0
    t.integer  "S112",                                          :default => 0
    t.integer  "S120",                                          :default => 0
    t.integer  "S121",                                          :default => 0
    t.integer  "S122",                                          :default => 0
    t.integer  "S130",                                          :default => 0
    t.integer  "S131",                                          :default => 0
    t.integer  "S132",                                          :default => 0
    t.integer  "S133",                                          :default => 0
    t.integer  "S140",                                          :default => 0
    t.integer  "S150",                                          :default => 0
    t.integer  "S160",                                          :default => 0
    t.integer  "S170",                                          :default => 0
    t.integer  "S180",                                          :default => 0
    t.integer  "S190",                                          :default => 0
    t.integer  "S200",                                          :default => 0
    t.integer  "S210",                                          :default => 0
    t.integer  "S211",                                          :default => 0
    t.integer  "S212",                                          :default => 0
    t.integer  "S213",                                          :default => 0
    t.integer  "S214",                                          :default => 0
    t.integer  "S220",                                          :default => 0
    t.integer  "S230",                                          :default => 0
    t.integer  "S240",                                          :default => 0
    t.integer  "S250",                                          :default => 0
    t.integer  "S260",                                          :default => 0
    t.decimal  "Kobk",            :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kobs",            :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kobzs",           :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kobgp",           :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kobdz",           :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Kobkz",           :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Krenprod",        :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Krenact",         :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Krensk",          :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Krenpz",          :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Krenps",          :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Krenor",          :precision => 6, :scale => 4, :default => 0.0
    t.decimal  "Krenchp",         :precision => 6, :scale => 4, :default => 0.0
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "form_two_reports", ["enterprise_id", "date_period_beg", "date_period_end"], :name => "two_enterpise_id_period"
  add_index "form_two_reports", ["enterprise_id", "date_period_beg"], :name => "two_enterpise_id_period_beg"
  add_index "form_two_reports", ["enterprise_id", "date_period_end"], :name => "two_enterpise_id_period_end"
  add_index "form_two_reports", ["enterprise_id"], :name => "index_form_two_reports_on_enterprise_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",           :null => false
    t.string   "encrypted_password",     :default => "",           :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  :default => false
    t.string   "username",               :default => ""
    t.text     "contact_info",           :default => ""
    t.string   "dogovor_nomer",          :default => ""
    t.date     "dogovor_begin",          :default => '2012-08-28'
    t.date     "dogovor_end",            :default => '2013-08-28'
    t.date     "last_pay_date"
    t.date     "last_active_date",       :default => '2012-09-12'
    t.boolean  "curent_status",          :default => true
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
