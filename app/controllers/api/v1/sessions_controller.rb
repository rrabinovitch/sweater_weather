class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if user
      render json: UserSerializer.new(user)
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
