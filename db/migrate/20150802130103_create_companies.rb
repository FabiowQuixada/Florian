class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|

      t.string :trading_name,                  null: false, unique: true # Nome fantasia
      t.string :name,                    null: false, unique: true            # Razao social

     t.string :cnpj, null: false
     t.string :cep
    t.string :address, null: false
    t.string  :neighborhood
    t.string  :city
     t.string :state
   t.string  :email_address
  t.string    :website
  t.text :remark

    t.integer :category, null: false
    t.integer :group,      null: false

    # Donation
    t.integer :contract
    t.date :first_parcel
    t.integer :payment_frequency
   t.integer   :payment_period

      t.timestamps null: false
    end

    add_reference :receipt_emails, :company, index: true, foreign_key: true, unique: true, null: false

  end
end
