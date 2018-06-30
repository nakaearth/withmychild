Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :twitter, ENV["TWITTER_API_TOKEN"], ENV["TWITTER_SECRET_TOKEN"]
  provider :google_oauth2, ENV["GOOGLE_APP_ID"], ENV["GOOGLE_APP_SECRET"],
    {
      scope: 'email',
      prompt: 'select_account',
      image_aspect_ratio: 'square',
    }
end
# OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)
