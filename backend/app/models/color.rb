class Color < ApplicationRecord
  include Rails.application.routes.url_helpers
  include Status::Enum

  has_one_attached :image
  attribute :_remove_image, :boolean, default: false

  validates :description, presence: true, length: { maximum: 60 }
  after_save :remove_image_if_necessary

  default_scope -> { order(:description) }

  def self.ransackable_attributes(auth_object = nil)
    [ "description" ]
  end

  def image_path
    image.attached? ? rails_blob_path(image, only_path: true) : nil
  end

  private

  def remove_image_if_necessary
    image.purge if _remove_image?
  end
end
