class SaleMethodsController < CrudController
  def initialize
    @model = SaleMethod
    @parameters = { sale_method: [ :description, :position, :status ] }
  end
end
