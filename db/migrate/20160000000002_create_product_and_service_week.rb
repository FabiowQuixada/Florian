class CreateProductAndServiceWeek < ActiveRecord::Migration
  def change
    create_table :product_and_service_weeks do |t|
      t.integer :number,	null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps null: false
    end

    add_reference :product_and_service_weeks, :product_and_service_datum, index: true, foreign_key: true
  end
end
