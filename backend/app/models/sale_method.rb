class SaleMethod < ApplicationRecord
  include Status::Enum

  validates :description, presence: true, length: { maximum: 60 }

  def self.ransackable_attributes(auth_object = nil)
    [ "description", "position" ]
  end
end
