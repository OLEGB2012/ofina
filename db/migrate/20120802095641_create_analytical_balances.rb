class CreateAnalyticalBalances < ActiveRecord::Migration
  def change
    create_table :analytical_balances do |t|
      t.integer "enterprise_id"
      t.date    "date_period_beg", "date_period_end" # Охваченный расчётом интервал на момент формирования итогов.
      t.integer "row_type", default: 0 # Тип строки отчёта, внутрений признак, который будет использоваться для форматирования строки отчёта во вьюхе.
      t.string  "G1", "G2", default: "" # Графы 1 и 2 отчёта - строковые.
      t.integer "G3", default: 0 # Графы 3,5,7 и 9 отчёта - целочисленные.
      t.column   :G4, :decimal, :precision => 7, :scale => 2, :default => 0 # Дробные графы с %-ми... 
      t.integer "G5", default: 0 # Графы 3,5,7 и 9 отчёта - целочисленные.
      t.column   :G6, :decimal, :precision => 7, :scale => 2, :default => 0 # Дробные графы с %-ми... 
      t.integer "G7", default: 0 # Графы 3,5,7 и 9 отчёта - целочисленные.      
      t.column   :G8, :decimal, :precision => 7, :scale => 2, :default => 0 # Дробные графы с %-ми...
      t.column   :G9, :decimal, :precision => 7, :scale => 2, :default => 0 # Дробные графы с %-ми...
      t.column   :G10, :decimal, :precision => 7, :scale => 2, :default => 0 # Дробные графы с %-ми...
      t.timestamps
    end
    add_index :analytical_balances, [:enterprise_id,:date_period_beg,:date_period_end], name: 'ab_enterpise_id_period'
    add_index :analytical_balances, [:enterprise_id,:date_period_beg], name: 'ab_enterpise_id_period_beg'
    add_index :analytical_balances, [:enterprise_id,:date_period_end], name: 'ab_enterpise_id_period_end'
    add_index :analytical_balances, :enterprise_id
  end
end
