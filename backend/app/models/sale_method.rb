class SaleMethod < CrudRecord
  with_options presence: true do
    validates :name, length: { maximum: 60 }
    validates :position, numericality: { only_integer: true }
  end
end
