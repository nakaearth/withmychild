# frozen_string_literal: true

class Tag < ApplicationRecord
  # include Searchable

  belongs_to :user
  belongs_to :place, optional: true, inverse_of: :tags

  validates :name, presence: true
end
