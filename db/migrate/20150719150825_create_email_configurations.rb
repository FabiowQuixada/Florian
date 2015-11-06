class CreateEmailConfigurations < ActiveRecord::Migration
  def change
    create_table :email_configurations do |t|
      t.text :signature,              null: false
      t.string :test_recipient
      t.string :bcc

      t.timestamps null: false
    end

    add_reference :emails, :email_configuration, index: true, foreign_key: true, null: false
  end
end
