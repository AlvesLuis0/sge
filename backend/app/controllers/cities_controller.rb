class CitiesController < CrudController
  def initialize
    @model = City
  end

  def index
    @q = City
      .includes(:state)
           .page(params[:page])
           .ransack(params[:q])
    @resources = @q.result
    render json: prepare_index_response(@resources), include: :state
  end
end
