# frozen_string_literal: true

class User < ApplicationRecord
  include IdEncryptable
  include Encryptedable

  attr_encrypted :uid

  validates :name, presence: true, length: { maximum: 60 }
  validates :uid, presence: true
  validates :email, length: { maximum: 80 }
  validates :provider, presence: true, length: { maximum: 30 }

  class << self
    def create_account(auth)
      Users::FacebookRegistration.new.call(auth)
    end
  end
end
