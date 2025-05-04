class SizeChartsController < CrudController
  def initialize
    @model = SizeChart
    @parameters = [
      :description, :status,
      sizes: [[:id, :description, :position, :_destroy]]
    ]
  end

  protected

  def set_resource
    if action_name == "show"
      @resource = SizeChart
                    .includes(:sizes)
                    .find(params.expect(:id))
    else
      super
    end
  end

  def resource_params
    p = params.permit(@parameters).to_h
    p[:sizes_attributes] = p.delete(:sizes)
    p
  end
end
