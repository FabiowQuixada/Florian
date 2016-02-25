class CreateServiceDatum < ActiveRecord::Migration
  def change
    create_table :service_data do |t|

      t.integer :psychology,                          null: false
      t.integer :physiotherapy,                          null: false
      t.integer :plastic_surgery,                          null: false
      t.integer :mesh_service,                          null: false
      t.integer :gynecology,                          null: false
      t.integer :occupational_therapy,          null: false

      t.timestamps null: false
    end

    add_reference :service_data, :product_and_service_week, index: true, foreign_key: true
  end
end