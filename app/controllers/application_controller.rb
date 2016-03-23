class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :authenticated?

  def require_login
    redirect_to login_path unless authenticated?
  end

  def skip_login
    redirect_to inbox_path if authenticated?
  end

  def authenticated?
    !!current_user
  end

  def current_user
    User.find_by_id(session[:user_id])
  end
end
