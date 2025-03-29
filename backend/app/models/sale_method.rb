class SaleMethod < ApplicationRecord
  include Status::Enum

  default_scope -> { order(:position) }

  validates :description, presence: true, length: { maximum: 60 }
  validates :position, presence: true
end
