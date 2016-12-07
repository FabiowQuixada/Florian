class RemoveUserFromSettings < ActiveRecord::Migration
  def change
  	remove_column :system_settings, :user_id
  end
end
