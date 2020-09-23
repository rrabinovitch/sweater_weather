class Api::V1::UsersController < ApplicationController
  def create
    if successful_password_confirmation
      User.create(user_params)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def successful_password_confirmation
    user_params[:password] == user_params[:password_confirmation]
  end
end
