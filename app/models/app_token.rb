# frozen_string_literal: true

class AppToken < ApplicationRecord
  validates :application_id, presence: true
end
