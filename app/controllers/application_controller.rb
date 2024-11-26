class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_admin_user!
    redirect_to books_path, alert: "You must be an admin to access this section" unless current_user&.admin?
  end

  def logged_in?
    current_user.present?
  end
end
