class ColorsController < CrudController
  def initialize
    @model = Color
    @parameters = [ :description, :status, :image, :_remove_image ]
  end

  def show
    render json: @resource, methods: :image_path
  end
end
