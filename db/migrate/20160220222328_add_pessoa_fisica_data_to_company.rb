class AddPessoaFisicaDataToCompany < ActiveRecord::Migration
  def change

    rename_column :companies, :trading_name, :registration_name

    add_column :companies, :cpf, :string
    add_column :companies, :entity_type, :integer

    change_column :companies, :cnpj, :string, null: true
    change_column :companies, :registration_name, :string, null: true
  end
end
