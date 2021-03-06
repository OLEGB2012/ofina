class CreateNsiMinUstCaps < ActiveRecord::Migration
  def change
    create_table :nsi_min_ust_caps do |t|
      t.integer :enterprise_id
      t.integer :summa , :default => 0   # Сумма минимального уставного капитала в миллионах белорусских рублей...
      t.date :date_vvod   # Дата вступления в силу (историзм)

      t.timestamps
    end
    add_index :nsi_min_ust_caps, [:enterprise_id,:date_vvod]
    add_index :nsi_min_ust_caps, :enterprise_id
  end
end