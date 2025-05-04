class CreateSizes < ActiveRecord::Migration[8.0]
  def change
    create_table :sizes do |t|
      t.belongs_to :size_chart, null: false, foreign_key: true
      t.string :description, null: false, limit: 4
      t.integer :position
    end
  end
end
