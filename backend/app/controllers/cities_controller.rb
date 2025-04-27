class CitiesController < ApplicationController
  before_action :set_resource, only: %i[ show ]

  def index
    @q = City
           .page(params[:page])
           .ransack(params[:q])
    @resources = @q.result
    render json: {
      resources: @resources,
      meta: {
        total_pages: @resources.total_pages,
        per_page: @resources.default_per_page,
        total_count: @resources.total_count,
        current_page: @resources.current_page
      }
    }
  end

  def show
    render json: @resource
  end

  protected

  def set_resource
    @resource = City.find(params.expect(:id))
  end
end
