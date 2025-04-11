class City < ApplicationRecord
  belongs_to :state

  default_scope -> { order(:name) }

  validates :name, presence: true, length: { maximum: 60 }
end
