module Crud
  module Extension
    extend ActiveSupport::Concern

    included do
      before_action :set_resource, only: %i[ show update destroy ]

      def index
        @resources = model.not_status_deleted
        render json: @resources
      end

      def show
        render json: @resource
      end

      def create
        @resource = model.create!(resource_params)
        render json: { messages: [ "Registro salvo: #{@resource.id}" ] }, status: :created, location: @resource
      end

      def update
        @resource.update!(resource_params)
        render json: @resource
      end

      def destroy
        @resource.status_deleted!
        render json: { messages: [ "Registro excluído" ] }
      end

      protected

      def set_resource
        @resource = model.not_status_deleted.find(params.expect(:id))
      end

      def resource_params
        raise "@parameters não especificado" if @parameters.nil?
        params.expect(@parameters)
      end

      def model
        raise "@model não especificado" if @model.nil?
        @model
      end
    end
  end
end
