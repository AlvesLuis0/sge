class ColorsController < CrudController
  def initialize
    @model = Color
    @parameters = [ :description, :status, :image ]
  end

  def show
    render json: @resource, methods: :image_path
  end

  private

  def resource_params
    params.permit(@parameters)
  end
end
