class OperationCodesController < ApplicationController
  def initialize
    @model = OperationCode
    @parameters = { operation_code: [ :description, :operation_type, :entry_exit, :updates_stock, :input_quantity_on_inclusion, :input_quantity_on_update, :input_price_on_inclusion, :input_price_on_update, :status ] }
  end
end
