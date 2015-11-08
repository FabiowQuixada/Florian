class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :simple_name,                  null: false, unique: true
      t.string :long_name,                    null: false, unique: true

     t.string :cnpj, null: false
     t.string :cep
    t.string :address, null: false
    t.string  :neighborhood
    t.string  :city
     t.string :state
   t.string  :email_address
  t.string    :website

    t.integer :category, null: false
    t.integer :group,      null: false

    # Donation
    t.string  :donation
    t.date :first_parcel
    t.date :last_parcel
    t.text :remark
    t.integer :parcel_frequency
   t.string   :total_period

    # Contacts
  t.string   :resp_name
  t.string   :resp_cellphone
   t.string  :resp_phone
 t.string   :resp_fax
   t.string  :resp_role
  t.string   :resp_email_address

 t.string   :assistant_name
 t.string   :assistant_phone
  t.string   :assistant_cellphone
  t.string  :assistant_email_address

  t.string   :financial_name
   t.string  :financial_phone
  t.string  :financial_cellphone
  t.string   :financial_email_address

      t.timestamps null: false
    end

    add_reference :emails, :company, index: true, foreign_key: true, unique: true, null: false

  end
end
