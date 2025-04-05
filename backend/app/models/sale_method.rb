class SaleMethod < ApplicationRecord
  include Status::Enum

  default_scope -> { order(:position) }

  validates :description, presence: true, length: { maximum: 60 }

  def self.ransackable_attributes(auth_object = nil)
    [ "description" ]
  end
end
