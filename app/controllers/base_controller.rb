class BaseController < ApplicationController
  attr_reader :current_user

  before_action :authorize_request


  private

  def authorize_request
    command = AuthorizeRequest.call(request.headers)

    @current_user = command.result if command.success?
    render json: { error: "Not Authorized" }, status: 401 unless command.success?
  end
end