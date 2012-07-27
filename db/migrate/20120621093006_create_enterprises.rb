class CreateEnterprises < ActiveRecord::Migration
  def change
    create_table :enterprises do |t|
      t.integer    "parent_id", default: 0
      t.integer    "user_id"
      t.string     "org_name"                       # Организация                            
      t.string     "uch_nomer_plat", limit: 9       # Учетный номер плательщика              
      t.string     "vid_econom_deyatel"             # Вид экономической деятельности         
      t.string     "organiz_pravo_form"             # Организационно-правовая форма          
      t.string     "organ_upravlen"                 # Орган управления                       
      t.string     "edinic_izmer", limit: 20        # Единица измерения                      
      t.string     "adres"                          # Адрес
      t.column :K1, :decimal, :precision => 3, :scale => 2, :default => 0, :range [..] # Норматив коэф-та текущей ликвидности
      t.column :K2, :decimal, :precision => 3, :scale => 2, :default => 0 # Норматив коэф-та обеспеченности собственными оборотными средствами
      t.column :K3, :decimal, :precision => 3, :scale => 2, :default => 0 # Норматив коэф-та обеспеченности финансовых обязательств активами
      t.date       "rab_date_beg" # Начальная дата рабочего интервала
      t.date       "rab_date_end" # Конечная дата рабочего интервала
      t.timestamps      
    end    
    add_index :enterprises, :user_id
    add_index :enterprises, :parent_id
    add_index :enterprises, [:parent_id,:id]
  end
end