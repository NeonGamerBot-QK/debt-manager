class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    return redirect_to root_path, alert: "Authentication failed" unless auth

    user = User.find_or_create_by(slack_id: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: "Signed in as #{user.name}"
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Signed out"
  end
end