class CreateFormFourReports < ActiveRecord::Migration
  def change
    create_table :form_four_reports do |t|
      t.integer "enterprise_id"
      t.date "date_period_beg", "date_period_end"
      t.integer "S020", "S021", "S022", "S023", "S024", "S030", "S031", "S032", "S033", "S034", "S040", "S050", 
                "S051", "S052", "S053", "S054", "S055", "S060", "S061", "S062", "S063", "S064", "S070", "S080", 
                "S081", "S082", "S083", "S084", "S090", "S091", "S092", "S093", "S094", "S095", "S100", "S110", 
                "S120", "S130", "S140", default: 0
      t.timestamps
    end
    add_index :form_four_reports, :enterprise_id
    add_index :form_four_reports, [:enterprise_id,:date_period_beg,:date_period_end], name: 'four_enterpise_id_period'
    add_index :form_four_reports, [:enterprise_id,:date_period_beg], name: 'four_enterpise_id_period_beg'
    add_index :form_four_reports, [:enterprise_id,:date_period_end], name: 'four_enterpise_id_period_end'
  end
end