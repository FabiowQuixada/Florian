class AddStatusToProductAndServiceEmails < ActiveRecord::Migration
  def change
  	add_column :product_and_service_emails, :status,   :integer,   null: false, default: 0
  	add_column :product_and_service_emails, :send_date, :date
  end
end
