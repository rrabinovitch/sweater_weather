class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    # binding.pry
    if user
      render json: UserSerializer.new(user)
    elsif user.nil?
      render json: { body: 'User not found' }, status: 401
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
