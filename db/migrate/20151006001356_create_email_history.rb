class CreateEmailHistory < ActiveRecord::Migration
  def change
    create_table :email_histories do |t|
      t.string   :body,                                                          null: false
      t.decimal  :value,                  precision: 8, scale: 2,                null: false
      t.datetime :created_at,                                                    null: false
      t.string   :recipients_array,                                              null: false
      t.integer  :send_type,                                                     null: false
    end

    add_reference :email_histories, :user, index: true, foreign_key: true, null: false
    add_reference :email_histories, :receipt_email, index: true, foreign_key: true, null: false
  end
end
