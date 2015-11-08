class CreateCompanyDonations < ActiveRecord::Migration
  def change
    create_table :company_donations do |t|
      t.decimal :value, :precision => 8, :scale => 2,                       null: false
      t.date :donation_date,                       null: false
      t.text :remark
      t.references :user, index: true, foreign_key: true,                       null: false
      t.references :company, index: true, foreign_key: true,                       null: false

      t.timestamps null: false
    end
  end
end
