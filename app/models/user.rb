# frozen_string_literal: true

class User < ApplicationRecord
  include IdEncryptable
  include Encryptedable

  attr_encrypted :uid

  has_many :places

  validates :name, presence: true, length: { maximum: 60 }
  validates :uid, presence: true
  validates :email, length: { maximum: 80 }
  validates :provider, presence: true, length: { maximum: 30 }

  class << self
  end
end
