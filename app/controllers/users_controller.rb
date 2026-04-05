class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode(user_id: user.id)

      render json: {
        user: user,
        auth_token: token,
        message: "Signup successful"
      }, status: :created
    else
      render json: {
        errors: user.errors.full_messages,
        message: user.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end