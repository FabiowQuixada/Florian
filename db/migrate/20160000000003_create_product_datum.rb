class CreateProductDatum < ActiveRecord::Migration
  def change
    create_table :product_data do |t|

      t.integer :mesh,                          null: false
      t.integer :cream,                          null: false
      t.integer :protector,                          null: false
      t.integer :silicon,                          null: false
      t.integer :mask,                          null: false
      t.integer :foam,                          null: false
      t.integer :skin_expander,                          null: false
      t.integer :cervical_collar,                          null: false

      t.timestamps null: false
    end

    add_reference :product_data, :product_and_service_week, index: true, foreign_key: true
  end
end