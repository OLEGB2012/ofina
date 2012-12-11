class AddChaToFormOneReports < ActiveRecord::Migration
  def change
    add_column :form_one_reports, :Cha, :integer, :default => 0   # Чистые Активы
  end
end