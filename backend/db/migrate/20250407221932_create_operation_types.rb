class CreateOperationTypes < ActiveRecord::Migration[8.0]
  def change
    create_enum :operation_types, [ 'sale', 'consignment', 'return' ]
  end
end
