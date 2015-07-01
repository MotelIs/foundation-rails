class Api::V1::BaseController < ApplicationController
  respond_to :json

  skip_before_filter :verify_authenticity_token
  before_action :doorkeeper_authorize!

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def guardian
    @guardian ||= Guardian.new(current_user)
  end

  def render_unauthorized
    error_response "You are not authenticated", 401
  end

  def unauthorized!
    error_response "You do not have permission", 403
  end

  def error_response message, status
    render json: {
      errors: [
        {
          status: status.to_s,
          title: message
        }
      ]
    }, status: status
  end

  def invalid_resource!(errors = [])
    api_error(status: 422, errors: errors)
  end

  def render_json_error message, status = 422
    return render :json => {errors: [message]}, :status => status
  end
end
