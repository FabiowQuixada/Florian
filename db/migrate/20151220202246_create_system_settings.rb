class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|

      # Product And Service E-mail
      t.string :pse_recipients_array,                       null: false
      t.integer :pse_day_of_month,                          null: false
      t.string :pse_title,                       null: false
      t.string :pse_body,                                   null: false

      # Receipt Email
      t.string :re_title,                       null: false
      t.string :re_body,                                   null: false

      t.timestamps null: false
    end

   add_reference :system_settings, :user, index: true, foreign_key: true, unique: true, null: false
 end
end