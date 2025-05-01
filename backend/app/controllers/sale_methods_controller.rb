class SaleMethodsController < CrudController
  def initialize
    @model = SaleMethod
    @parameters = [ :description, :position, :status ]
  end
end
