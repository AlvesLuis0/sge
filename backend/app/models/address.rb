class Address < ApplicationRecord
  belongs_to :person
  belongs_to :city, optional: true

  validates :street, presence: true, length: { maximum: 60 }, if: :street?
  validates :complement, presence: true, length: { maximum: 60 }, if: :complement?
  validates :zip_code, presence: true, length: { is: 8 }, numericality: { only_integer: true }, if: :zip_code?
  validates :neighborhood, presence: true, length: { maximum: 60 }, if: :neighborhood?
end
