class CreateStates < ActiveRecord::Migration[8.0]
  def change
    create_table :states do |t|
      t.string :name, null: false, limit: 60
      t.integer :ibge, null: false
      t.string :uf, null: false, limit: 2
    end
  end
end
