class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name,                         null: false, unique: true
      t.string :description,                  null: false
      t.boolean :active,      default: true,  null: false

      t.timestamps null: false
    end

    add_reference :users, :role, index: true, foreign_key: true, null: false
  end
end
