class CategoriesController < CrudController
  def initialize
    @model = Category
    @parameters = { category: [ :description, :status ] }
  end
end
