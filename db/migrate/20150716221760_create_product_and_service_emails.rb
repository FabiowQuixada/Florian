class CreateProductAndServiceEmails < ActiveRecord::Migration
  def change
    create_table :product_and_service_emails do |t|

      t.string :competence_date,                                   null: false

      # Services
      t.integer :psychology,                          null: false
      t.integer :physiotherapy,                          null: false
      t.integer :plastic_surgery,                          null: false
      t.integer :mesh_service,                          null: false
      t.integer :gynecology,                          null: false
      t.integer :occupational_therapy,          null: false

      t.integer :psychology_return,                          null: false
      t.integer :physiotherapy_return,                          null: false
      t.integer :plastic_surgery_return,                          null: false
      t.integer :mesh_service_return,                          null: false
      t.integer :gynecology_return,                          null: false
      t.integer :occupational_therapy_return,          null: false

      # Products
      t.integer :mesh,                          null: false
      t.integer :cream,                          null: false
      t.integer :protector,                          null: false
      t.integer :silicon,                          null: false
      t.integer :mask,                          null: false
      t.integer :foam,                          null: false
      t.integer :skin_expander,                          null: false
      t.integer :cervical_collar,                          null: false

      t.timestamps null: false
    end
  end
end