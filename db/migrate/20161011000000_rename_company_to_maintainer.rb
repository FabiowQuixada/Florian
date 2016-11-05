class RenameCompanyToMaintainer < ActiveRecord::Migration
  def change
    rename_table :companies, :maintainers
    rename_column :donations, :company_id, :maintainer_id
	rename_column :contacts, :company_id, :maintainer_id
	rename_column :receipt_emails, :company_id, :maintainer_id
  end 

  def data
    sql = "update audits set auditable_type = 'Maintainer' where auditable_type = 'Company'"
    ActiveRecord::Base.connection.execute(sql)
  end

  def rollback
    sql = "update audits set auditable_type = 'Company' where auditable_type = 'Maintainer'"
    ActiveRecord::Base.connection.execute(sql)
  end
end