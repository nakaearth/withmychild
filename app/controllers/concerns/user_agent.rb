# frozen_string_literal: true

module UserAgent
  extend ActiveSupport::Concern

  def mobile?
    browser.device.iphone? || browser.platform.android? || browser.platform.windows_phone?
  end

  def tablet?
    browser.device.tablet?
  end
end
