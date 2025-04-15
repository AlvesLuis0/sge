class CrudController < ApplicationController
  before_action :set_resource, only: %i[ show update destroy ]

  def initialize
    @model = nil
    @parameters = nil
    raise "@model and @parameters precisam ser definidos" if @model.nil? || @parameters.nil?
  end

  def index
    @q = @model
      .not_status_deleted
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

  def create
    @resource = @model.create!(resource_params)
    render json: { messages: [ "Registro salvo: #{@resource.id}" ] }, status: :created, location: @resource
  end

  def update
    @resource.update!(resource_params)
    render json: { messages: [ "Registro salvo: #{@resource.id}" ] }
  end

  def destroy
    @resource.status_deleted!
    render json: { messages: [ "Registro excluído" ] }
  end

  protected

  def set_resource
    @resource = @model.not_status_deleted.find(params.expect(:id))
  end

  def resource_params
    params.expect(@parameters)
  end
end
