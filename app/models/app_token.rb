# frozen_string_literal: true

require "securerandom"

class AppToken < ApplicationRecord
  # validates :application_id, presence: true, uniquness: { scope: :version_id }

  def generate_token
    self.secreat_key = SecureRandom.base64(20)
  end
end
