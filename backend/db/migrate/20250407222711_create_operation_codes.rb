class CreateOperationCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :operation_codes do |t|
      t.string :description, null: false, limit: 60
      t.enum :operation_type, enum_type: :operation_types, null: false, index: true
      t.enum :entry_exit, enum_type: :entry_exit, null: false, index: true
      t.boolean :updates_stock, null: false
      t.boolean :input_quantity_on_inclusion, null: false
      t.boolean :input_quantity_on_update, null: false
      t.boolean :input_price_on_inclusion, null: false
      t.boolean :input_price_on_update, null: false
      t.enum :status, enum_type: :statuses, null: false, default: "active", index: true
    end
  end
end
