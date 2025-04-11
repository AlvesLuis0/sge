class State < ApplicationRecord
  default_scope -> { order(:name) }

  validates :name, presence: true, length: { maximum: 60 }
  validates :uf, presence: true, length: { is: 2 }
end
