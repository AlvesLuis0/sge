class SizeChart < ApplicationRecord
  include Status::Enum

  has_many :sizes
  accepts_nested_attributes_for :sizes, allow_destroy: true

  validates :description, presence: true, length: { maximum: 60 }
  validate :must_have_at_least_one_size

  default_scope -> { order(:description) }

  def self.ransackable_attributes(auth_object = nil)
    [ "description" ]
  end

  private

  def must_have_at_least_one_size
    errors.add(:size_chart, "precisa ter pelo menos um tamanho") if sizes.empty?
  end
end
