# frozen_string_literal: true

class CrudController < ApplicationController
  before_action :set_resource, only: %i[ show update destroy ]

  def initialize
    super
    @model = CrudRecord
  end

  def index
    @resources = @model.all
    render json: @resources
  end

  def show
    render json: @resource
  end

  def create
    @resource = @model.new(resource_params)
    if @resource.save
      render json: @resource, status: :created, location: @resource
    else
      render json: @resource.errors, status: :unprocessable_content
    end
  end

  def update
    if @resource.update(resource_params)
      render json: @resource
    else
      render json: @resource.errors, status: :unprocessable_content
    end
  end

  def destroy
    @resource.update!(status: StatusConstant.get_value(:deleted))
  end

  protected

  def set_resource
    @resource = @model.find(params.expect(:id))
  end

  def resource_params
    params.expect(resource: [ :status ])
  end
end
