class CreateProductAndServiceDatum < ActiveRecord::Migration
  def change
    create_table :product_and_service_data do |t|
      t.date :competence, null: false
      t.integer :status,	default: 0,	null: false

      t.timestamps null: false
    end
  end
end
