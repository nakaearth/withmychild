# frozen_string_literal: true

class Photo < ApplicationRecord
  # mount_uploader :image, ImageUploader

  alias_attribute :start_time, :created_at

  belongs_to :user

  validates :description, length: { maximum: 140 }

  def thumb_url
    image.thumb.url
  end

  def original_url
    image_url(:original)
  end
end
