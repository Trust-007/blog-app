class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def verified_request?
    super || request_from_localhost?
  end

  def request_from_localhost?
    request.remote_ip == '127.0.0.1' || request.remote_ip == '::1'
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :bio, :photo, :email, :password, :posts_counter) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :bio, :photo, :email, :posts_counter, :password, :current_password)
    end
  end
end
