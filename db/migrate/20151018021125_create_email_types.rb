class CreateEmailTypes < ActiveRecord::Migration
  def change
    create_table :email_types do |t|
      t.string :name, uniqueness: true
      t.string :email_title

      t.timestamps null: false
    end

    add_reference :email_types, :email, index: true, foreign_key: true, null: false
  end
end
