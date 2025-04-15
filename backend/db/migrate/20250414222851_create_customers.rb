class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.belongs_to :person, null: false, foreign_key: true
      t.datetime :registered_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.text :note, limit: 1000
      t.enum :status, enum_type: :statuses, null: false, default: "active", index: true
    end
  end
end
