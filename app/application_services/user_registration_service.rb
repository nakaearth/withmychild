# frozen_string_literal: true

class UserRegistrationService
  def initialize(params)
    @params = params
  end

  def call
    case auth[:provider]
    when 'facebook'
      UserRegistration::FacebookRegistration.new(@params).call
    when 'twitter'
      UserRegistration::TwitterRegistration.new(@params).call
    end
  end
end
