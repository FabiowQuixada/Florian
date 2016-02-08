class AddPrivateRecipientsToSystemSettings < ActiveRecord::Migration
  def change
  	add_column :system_settings, :pse_private_recipients_array, :string,   null: false, default: 'exemplo@yahoo.com.br'
  end
end
