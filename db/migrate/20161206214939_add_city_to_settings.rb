class AddCityToSettings < ActiveRecord::Migration
  def change
  	add_column :system_settings, :city, :string, null: false, default: 'Fortaleza'
  end
end
