class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.belongs_to :person, null: false, foreign_key: true
      t.enum :contact_type, null: false, enum_type: :contact_types, index: true
      t.string :email, limit: 100
      t.string :mobile_number, limit: 13
    end
  end
end
