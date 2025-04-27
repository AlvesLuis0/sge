class CreatePeople < ActiveRecord::Migration[8.0]
  def change
    create_table :people do |t|
      t.string :name, null: false, limit: 100
      t.enum :person_type, null: false, enum_type: :person_types, index: true

      t.string :cpf, limit: 11, index: true
      t.string :rg, limit: 15
      t.string :issuing_agency, limit: 20
      t.datetime :birth_date
      t.enum :marital_status, enum_type: :marital_statuses, index: true

      t.string :cnpj, limit: 14, index: true
      t.string :state_registration, limit: 20
      t.string :trade_name, limit: 40
    end
  end
end
