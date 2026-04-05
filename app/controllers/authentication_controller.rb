class AuthenticationController < ApplicationController
  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: {
        auth_token: command.result,
        message: 'Login Successful'
      }, status: :ok
    else
    render json: {
      error: command.errors,
      message: command.errors.full_messages.join(", ")
    }, status: :unauthorized
    end
  end
end