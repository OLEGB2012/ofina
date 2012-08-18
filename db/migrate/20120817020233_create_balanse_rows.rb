class CreateBalanseRows < ActiveRecord::Migration
  def change
    create_table :balanse_rows do |t|
      t.integer "enterprise_id"
      t.integer "diag_type", default:0  # тип диаграммы (см. Просмотр результатов аналитический баланс(графично) - расчёты в контроллере).
      t.date    "date_period_beg"       # Интервал дат сумм в сериях.
      t.date    "date_period_end"       # 
      t.string  "name", default: ""     # имя серии - строка баланса. 
      t.timestamps
    end
    add_index :balanse_rows, [:enterprise_id,:date_period_beg,:date_period_end], name: 'br_enterpise_id_period'
    add_index :balanse_rows, [:enterprise_id,:date_period_beg], name: 'br_enterpise_id_period_beg'
    add_index :balanse_rows, [:enterprise_id,:date_period_end], name: 'br_enterpise_id_period_end'
    add_index :balanse_rows, :enterprise_id
  end
end
