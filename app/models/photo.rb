# frozen_string_literal: true

class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader

  alias_attribute :start_time, :created_at

  belongs_to :user
  belongs_to :place

  def thumb_url
    image.thumb.url
  end

  def original_url
    image_url(:original)
  end
end
