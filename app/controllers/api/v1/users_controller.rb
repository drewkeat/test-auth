class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: {user: UserSerializer.new(@user)}, status: :created
    else
      render json: { error: 'failed to create user' }, status: :unprocessable_entity
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password, :bio, :avatar)
  end
end
