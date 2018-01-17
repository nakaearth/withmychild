# frozen_string_literal: true

class Place < ApplicationRecord
  include PlaceSearchable

  alias_attribute :start_time, :created_at

  # NOTE: addressに値が入るとlatitudeとlongitude にaddressの緯度経度が入る
  geocoded_by :address

  belongs_to :user
  has_many :photos, inverse_of: :place
  has_many :tags, inverse_of: :place

  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :tags

  validates :description, length: { maximum: 1000 }
  validates :address, length: { maximum: 80 }

  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }

  def first_image_url(photo_size = nil)
    return ImageUploader.new.default_url if photos.empty?

    return photos.first.image.url unless photo_size

    photos.first.image.url(photo_size.to_sym)
  end
end
