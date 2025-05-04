class SaleMethod < ApplicationRecord
  include Status::Enum

  validates :description, presence: true, length: { maximum: 60 }

  default_scope -> { order(:position) }

  def self.ransackable_attributes(auth_object = nil)
    [ "description" ]
  end
end
