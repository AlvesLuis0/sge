class OperationCode < ApplicationRecord
  include Status::Enum
  include OperationType::Enum
  include EntryExit::Enum

  default_scope -> { order(:description) }

  attribute :updates_stock, :boolean, default: true
  attribute :input_quantity_on_inclusion, :boolean, default: false
  attribute :input_quantity_on_update, :boolean, default: true
  attribute :input_price_on_inclusion, :boolean, default: false
  attribute :input_price_on_update, :boolean, default: true

  validates :description, presence: true, length: { maximum: 60 }
  validates :updates_stock, inclusion: [ true, false ]
  validates :input_quantity_on_inclusion, inclusion: [ true, false ]
  validates :input_quantity_on_update, inclusion: [ true, false ]
  validates :input_price_on_inclusion, inclusion: [ true, false ]
  validates :input_price_on_update, inclusion: [ true, false ]

  def self.ransackable_attributes(auth_object = nil)
    [ "description" ]
  end
end
