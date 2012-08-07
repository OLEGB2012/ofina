class CreateFormOneReports < ActiveRecord::Migration
  def change
    create_table :form_one_reports do |t|
      t.integer "enterprise_id"
      t.date    "date_period"
      t.integer "S110", "S120", "S130", "S131", "S132", "S133", "S140", "S150", "S160", "S170",
                "S180", "S190", "S210", "S211", "S212", "S213", "S214", "S215", "S216", "S220", 
                "S230", "S240", "S250", "S260", "S270", "S280", "S290", "S300", "S410", "S420",
                "S430", "S440", "S450", "S460", "S470", "S480", "S490", "S510", "S520", "S530", 
                "S540", "S550", "S560", "S590", "S610", "S620", "S630", "S631", "S632", "S633", 
                "S634", "S635", "S636", "S637", "S638", "S640", "S650", "S660", "S670", "S690", 
                "S700", default: 0
      t.column :K1,   :decimal, :precision => 3, :scale => 2, :default => 0 # Коэф-т текущей ликвидности
      t.column :K2,   :decimal, :precision => 3, :scale => 2, :default => 0 # Коэф-т обеспеченности собственными оборотными средствами
      t.column :K3,   :decimal, :precision => 3, :scale => 2, :default => 0 # Коэф-т обеспеченности финансовых обязательств активами        
      t.column :Kabsl,:decimal, :precision => 4, :scale => 3, :default => 0 # Коэф-т абсолютной ликвидности
      t.column :Kcap, :decimal, :precision => 4, :scale => 3, :default => 0 # Коэф-т капитализации
      t.column :Kfnez,:decimal, :precision => 4, :scale => 3, :default => 0 # Коэф-т финансовой независимости
      t.timestamps
    end
    add_index :form_one_reports, [:enterprise_id,:date_period]
    add_index :form_one_reports, :enterprise_id
  end
end