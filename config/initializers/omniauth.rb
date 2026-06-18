# config/initializers/omniauth.rb
OmniAuth.config.allowed_request_methods = %i[get post]
OmniAuth.config.silence_get_warning = true

unless ENV["SECRET_KEY_BASE_DUMMY"]
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :hack_club,
      Rails.application.credentials.hack_club.client_id!,
      Rails.application.credentials.hack_club.client_secret!,
      scope: "openid email name slack_id"
  end
end
