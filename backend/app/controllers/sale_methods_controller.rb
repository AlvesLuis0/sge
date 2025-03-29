class SaleMethodsController < ApplicationController
  before_action :set_sale_method, only: %i[ show update destroy ]

  def index
    @sale_methods = SaleMethod.not_deleted
    render json: @sale_methods
  end

  def show
    render json: @sale_method
  end

  def create
    @sale_method = SaleMethod.create!(sale_method_params)
    render json: @sale_method, status: :created, location: @sale_method
  end

  def update
    @sale_method.update!(sale_method_params)
    render json: @sale_method
  end

  def destroy
    @sale_method.deleted!
  end

  private

  def set_sale_method
    @sale_method = SaleMethod.not_deleted.find(params.expect(:id))
  end

  def sale_method_params
    params.expect(sale_method: [ :description, :position, :status ])
  end
end
