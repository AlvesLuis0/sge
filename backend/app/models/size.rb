class Size < ApplicationRecord
  belongs_to :size_chart

  validates :description, presence: true, length: { maximum: 4 }

  default_scope -> { order(:position) }
end
