class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  def record_not_found(error)
    render json: { 
      status: { 
        code: 404, 
        message: error.message
      }
    }, status: :not_found
  end

  def record_invalid(error)
    render json: { 
      status: { 
        code: 422, 
        message: error.record.errors.full_messages
      }
    }, status: :unprocessable_entity
  end
end
