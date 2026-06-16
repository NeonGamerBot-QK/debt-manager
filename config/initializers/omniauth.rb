# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :hack_club,
    ENV.fetch("HACK_CLUB_CLIENT_ID"),
    ENV.fetch("HACK_CLUB_CLIENT_SECRET"),
    scope: "openid email name slack_id"
end