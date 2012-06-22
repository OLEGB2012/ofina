class CreateEnterprises < ActiveRecord::Migration
  def change
    create_table :enterprises do |t|
      t.integer    "user_id"
      t.string     "org_name" # Организация                            
      t.string     "uch_nomer_plat", limit: 9  # Учетный номер плательщика              
      t.string     "vid_econom_deyatel"        # Вид экономической деятельности         
      t.string     "organiz_pravo_form"        # Организационно-правовая форма          
      t.string     "organ_upravlen"            # Орган управления                       
      t.string     "edinic_izmer", limit: 20   # Единица измерения                      
      t.string     "adres"                     # Адрес 
      t.timestamps      
    end    
    add_index :enterprises, :user_id
  end
end