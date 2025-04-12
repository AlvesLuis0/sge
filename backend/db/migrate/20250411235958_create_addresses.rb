class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.belongs_to :person, null: false, foreign_key: true
      t.string :street, limit: 60
      t.integer :number
      t.string :complement, limit: 60
      t.string :zip_code, limit: 8
      t.string :neighborhood, limit: 60
      t.belongs_to :city, foreign_key: true
    end
  end
end
