class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    session_user_id = session[:user_id]

    @current_user ||= User.find(session_user_id) if session_user_id
  end

  def logged_in?
    !!current_user
  end

  def require_user
    return if logged_in?

    flash[:alert] = 'You must be logged in to perform that action'
    redirect_to login_path
  end
end
