class RemovePseDayFromSystemSetting < ActiveRecord::Migration
  def change
    remove_column :system_settings, :pse_day_of_month, :integer
  end
end
