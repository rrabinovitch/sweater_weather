class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)

    if user.save && successful_password_confirmation
      render json: UserSerializer.new(user), status: :created
    else
      render json: { body: user.errors.full_messages.to_sentence }, status: :bad_request
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
