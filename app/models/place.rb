# frozen_string_literal: true

class Place < ApplicationRecord
  alias_attribute :start_time, :created_at

  belongs_to :user
  has_many :photos, inverse_of: :place
  has_many :tags, inverse_of: :place

  accepts_nested_attributes_for :photos

  validates :description, length: { maximum: 1000 }
end
