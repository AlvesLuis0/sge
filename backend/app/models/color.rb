class Color < ApplicationRecord
  include Rails.application.routes.url_helpers
  include Status::Enum

  has_one_attached :image
  attribute :must_destroy_image, :boolean, default: false

  validates :description, presence: true, length: { maximum: 60 }

  def self.ransackable_attributes(auth_object = nil)
    [ "description" ]
  end

  def image_path
    image.attached? ? rails_blob_path(image, only_path: true) : nil
  end
end
