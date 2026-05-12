class LandingController < ApplicationController
  def index
     redirect_to dash_path if current_user
  end
end