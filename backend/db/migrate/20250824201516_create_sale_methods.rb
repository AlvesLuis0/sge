class CreateSaleMethods < ActiveRecord::Migration[8.0]
  def change
    create_table :sale_methods do |t|
      t.string :name, null: false, limit: 60
      t.integer :position, null: false
      t.integer :status, null: false
    end
  end
end
