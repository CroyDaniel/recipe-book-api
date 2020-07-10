class ApplicationController < ActionController::API
  def render_not_found_error
    render json: { errors: { detail: 'resource not found' } }, status: :not_found
  end
end
