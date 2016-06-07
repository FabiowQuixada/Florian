class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.decimal :value, precision: 8, scale: 2, null: false
      t.date :donation_date, null: false
      t.text :remark
      t.references :company, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
