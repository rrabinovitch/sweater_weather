class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if session_params[:email].nil? && session_params[:password].nil?
      render json: { error: 'Missing email and password'}, status: 401
    elsif session_params[:email].nil?
      render json: { error: 'Missing email' }, status: 401
    elsif user && user.authenticate(session_params[:password])
      render json: UserSerializer.new(user)
    elsif user && !user.authenticate(session_params[:password])
      render json: { error: 'Incorrect password' }, status: 401
    elsif user.nil?
      render json: { error: 'User not found' }, status: 401
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
