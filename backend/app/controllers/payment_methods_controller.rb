class PaymentMethodsController < ApplicationController
  def initialize
    @model = PaymentMethod
    @parameters = { payment_method: [ :description, :payment_type, :status ] }
  end
end
