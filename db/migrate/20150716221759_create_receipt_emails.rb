class CreateReceiptEmails < ActiveRecord::Migration
  def change
    create_table :receipt_emails do |t|
      t.string :recipients_array,                       null: false
      t.string :body,                                   null: false
      t.integer :day_of_month,                          null: false
      t.boolean :active, default: true, null: false
      t.decimal :value, precision: 8, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
