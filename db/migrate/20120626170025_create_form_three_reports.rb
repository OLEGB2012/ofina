class CreateFormThreeReports < ActiveRecord::Migration
  def change
    create_table :form_three_reports do |t|
      t.integer "enterprise_id"
      t.date "date_period_beg", "date_period_end"
      t.string "G1","G2" # Наименование показателей, номер строки 010, 020 и т.д...
      t.integer  "G3", "G4", "G5", "G6", "G7", "G8", "G9", "G10", default: 0
      t.timestamps
    end
    add_index :form_three_reports, [:enterprise_id,:date_period_beg,:date_period_end,:G2], name: 'three_enterpise_id_period_G2'
    add_index :form_three_reports, [:enterprise_id,:date_period_beg,:G2], name: 'three_enterpise_id_period_beg_G2'
    add_index :form_three_reports, [:enterprise_id,:date_period_end,:G2], name: 'three_enterpise_id_period_end_G2'
    add_index :form_three_reports, :enterprise_id
  end
end
