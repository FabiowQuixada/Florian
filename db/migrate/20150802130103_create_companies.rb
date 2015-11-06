class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :simple_name,                  null: false, unique: true
      t.string :long_name,                    null: false, unique: true
      t.boolean :active,      default: true,  null: false

      t.timestamps null: false
    end

    add_reference :emails, :company, index: true, foreign_key: true, unique: true, null: false

  end
end
