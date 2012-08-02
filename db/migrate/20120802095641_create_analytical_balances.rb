class CreateAnalyticalBalances < ActiveRecord::Migration
  def change
    create_table :analytical_balances do |t|
      
      t.timestamps
    end
  end
end
