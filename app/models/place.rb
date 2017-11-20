# frozen_string_literal: true

class Place < ApplicationRecord
  include Searchable

  alias_attribute :start_time, :created_at

  belongs_to :user
  has_many :photos, inverse_of: :place
  has_many :tags, inverse_of: :place

  accepts_nested_attributes_for :photos
  accepts_nested_attributes_for :tags

  validates :description, length: { maximum: 1000 }
  validates :address, length: { maximum: 80 }
end
