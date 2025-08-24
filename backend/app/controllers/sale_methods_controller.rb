class SaleMethodsController < ApplicationController
  before_action :set_sale_method, only: %i[ show update destroy ]

  def index
    @sale_methods = SaleMethod.all
    render json: @sale_methods
  end

  def show
    render json: @sale_method
  end

  def create
    @sale_method = SaleMethod.new(sale_method_params)
    if @sale_method.save
      render json: @sale_method, status: :created, location: @sale_method
    else
      render json: @sale_method.errors, status: :unprocessable_content
    end
  end

  def update
    if @sale_method.update(sale_method_params)
      render json: @sale_method
    else
      render json: @sale_method.errors, status: :unprocessable_content
    end
  end

  def destroy
    @sale_method.update!(status: StatusConstant.get_value(:deleted))
  end

  private

  def set_sale_method
    @sale_method = SaleMethod.find(params.expect(:id))
  end

  def sale_method_params
    params.expect(sale_method: [ :name, :position, :status ])
  end
end
