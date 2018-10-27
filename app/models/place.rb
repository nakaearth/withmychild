# frozen_string_literal: true

class Place < ApplicationRecord
  include PlaceSearchable
  include IdEncryptable

  alias_attribute :start_time, :created_at

  # NOTE: addressに値が入るとlatitudeとlongitude にaddressの緯度経度が入る
  geocoded_by :address

  belongs_to :user
  has_many :photos, inverse_of: :place, dependent: :delete_all
  has_many :tags, inverse_of: :place
  has_many :featured_images, inverse_of: :place, dependent: :delete_all

  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :featured_images

  validates :description, length: { maximum: 1000 }
  validates :address, length: { maximum: 80 }

  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }

  def first_image_url(photo_size = nil)
    return ImageUploader.new.default_url if photos.empty?

    return photos.first.image.url unless photo_size

    photos.first.image.url(photo_size.to_sym)
  end

  def photo_image_urls(photo_size = nil)
    return [ImageUploader.new.default_url] if photos.empty?

    return [photos.first.image.url] unless photo_size

    photos.map { |photo| photo.image.url }
  end

  def description_summary
    return description if description.length <= 80

    description[0..79] + '...'
  end
end
