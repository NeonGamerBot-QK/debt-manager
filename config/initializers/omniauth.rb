# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :hack_club,
    Rails.application.credentials.hack_club_client_id!,
    Rails.application.credentials.hack_club_client_secret!,
    scope: "openid email name slack_id"
end