class CreateFormTwoReports < ActiveRecord::Migration
  def change
    create_table :form_two_reports do |t|
      t.integer "enterprise_id"
      t.date "date_period_beg", "date_period_end"
      t.integer "S010", "S020", "S030", "S040", "S050", "S060", "S070", "S080", "S090", "S100", "S101", "S102", 
                "S103", "S104", "S110", "S111", "S112", "S120", "S121", "S122", "S130", "S131", "S132", "S133", 
                "S140", "S150", "S160", "S170", "S180", "S190", "S200", "S210", "S211", "S212", "S213", "S214", 
                "S220", "S230", "S240", "S250", "S260", default: 0
      # Показатели деловой активности
      t.column :Kobk,  :decimal, :precision => 6, :scale => 4, :default => 0 # 1. Коэфф. общей оборачиваемости капитала (коэфф. деловой активности).
      t.column :Kobs,  :decimal, :precision => 6, :scale => 4, :default => 0 # 2. Коэфф. оборачиваемости оборотных средств (краткосрочных активов).
      t.column :Kobzs, :decimal, :precision => 6, :scale => 4, :default => 0 # 3. Коэффициент оборачиваемости запаса сырья, материалов и полуфабрикатов.
      t.column :Kobgp, :decimal, :precision => 6, :scale => 4, :default => 0 # 4. Коэффициент оборачиваемости готовой продукции.
      t.column :Kobdz, :decimal, :precision => 6, :scale => 4, :default => 0 # 5. Коэффициент оборачиваемости дебиторской задолженности.
      t.column :Kobkz, :decimal, :precision => 6, :scale => 4, :default => 0 # 6. Коэффициент оборачиваемости кредиторской задолженности 
      # Показатели рентабельности
      t.column :Krenprod, :decimal, :precision => 6, :scale => 4, :default => 0 # 1. Рентабельность продаж
      t.column :Krenact , :decimal, :precision => 6, :scale => 4, :default => 0 # 2. Рентабельность активов
      t.column :Krensk  , :decimal, :precision => 6, :scale => 4, :default => 0 # 3. Рентабельность собственного капитала
      t.column :Krenpz  , :decimal, :precision => 6, :scale => 4, :default => 0 # 4. Рентабельность производственных затрат, составляющих себестоимость продукции, работ, услуг
      t.column :Krenps  , :decimal, :precision => 6, :scale => 4, :default => 0 # 5. Рентабельность полной себестоимости реализованной продукции, работ, услуг 
      t.column :Krenor  , :decimal, :precision => 6, :scale => 4, :default => 0 # 6. Рентабельность общих расходов коммерческой организации
      t.column :Krenchp , :decimal, :precision => 6, :scale => 4, :default => 0 # 7. Рентабельность расходов, обусловивших получение чистой прибыли коммерческой организации       
      t.timestamps
    end
    add_index :form_two_reports, [:enterprise_id,:date_period_beg,:date_period_end], name: 'two_enterpise_id_period'
    add_index :form_two_reports, [:enterprise_id,:date_period_beg], name: 'two_enterpise_id_period_beg'
    add_index :form_two_reports, [:enterprise_id,:date_period_end], name: 'two_enterpise_id_period_end'
    add_index :form_two_reports, :enterprise_id
  end
end
