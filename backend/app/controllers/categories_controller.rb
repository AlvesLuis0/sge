class CategoriesController < CrudController
  def initialize
    @model = Category
    @parameters = [ :description, :status ]
  end
end
