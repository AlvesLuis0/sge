class SaleMethodsController < ApplicationController
  include Crud::Extension

  def initialize
    @model = SaleMethod
    @parameters = { sale_method: [ :description, :position, :status ] }
  end
end
