class CreateBalanseValues < ActiveRecord::Migration
  def change
    create_table :balanse_values do |t|
      t.references :balanse_row
      t.date    "date_period"           # Дата суммы в серии.
      t.integer "summa", default: 0     # Сумма серии на дату.
      t.timestamps
    end
    add_index :balanse_values , :balanse_row_id
  end
end