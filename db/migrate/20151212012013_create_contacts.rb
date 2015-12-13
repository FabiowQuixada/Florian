class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|

      t.string :name
      t.string :position
      t.string :email_address
      t.string :telephone
      t.string :celphone
      t.string :fax

      t.integer :contact_type,           null: false

      t.timestamps null: false
    end

    add_reference :contacts, :company, index: true, foreign_key: true, null: false
  end
end
