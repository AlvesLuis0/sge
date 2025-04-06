class PaymentMethodsController < ApplicationController
  include Crud::Extension

  def initialize
    @model = PaymentMethod
    @parameters = { payment_method: [ :description, :payment_type, :status ] }
  end
end
