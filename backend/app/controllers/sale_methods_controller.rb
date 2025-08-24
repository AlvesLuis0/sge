class SaleMethodsController < CrudController
  def initialize
    super
    @model = SaleMethod
  end

  protected

  def resource_params
    params.expect(sale_method: [ :name, :position, :status ])
  end
end
