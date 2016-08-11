class RemoveTypeFromContact < ActiveRecord::Migration
  def change
    remove_column :contacts, :contact_type, :integer
  end
end
