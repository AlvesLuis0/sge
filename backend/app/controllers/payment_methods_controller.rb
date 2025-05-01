class PaymentMethodsController < CrudController
  def initialize
    @model = PaymentMethod
    @parameters = [ :description, :payment_type, :status ]
  end
end
