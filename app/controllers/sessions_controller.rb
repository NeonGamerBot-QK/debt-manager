class SessionsController < ApplicationController
  def create
  auth = request.env['omniauth.auth']
  session[:user] = {
    uid: auth['uid'],
    email: auth['info']['email'],
    name: auth['info']['name'],
  }
  redirect_to root_path, notice: "Signed in as #{session[:user][:name]}"
  end

  def destroy
    session[:user] = nil
    redirect_to root_path, notice: "Signed out"
  end
end