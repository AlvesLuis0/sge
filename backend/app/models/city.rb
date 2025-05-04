class City < ApplicationRecord
  belongs_to :state

  default_scope -> { order(:name) }

  def self.ransackable_attributes(auth_object = nil)
    ["name", "state_id"]
  end
end
