class CreateCities < ActiveRecord::Migration[8.0]
  def change
    create_table :cities do |t|
      t.belongs_to :state, null: false, foreign_key: true
      t.string :name, null: false, limit: 60
      t.integer :ibge, null: false
    end
  end
end
