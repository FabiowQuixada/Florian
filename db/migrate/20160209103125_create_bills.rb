class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
	t.date :competence, null: false
	t.decimal :water, :precision => 8, :scale => 2
	t.decimal :energy, :precision => 8, :scale => 2
	t.decimal :telephone, :precision => 8, :scale => 2
	t.timestamps null: false
    end
  end
end
