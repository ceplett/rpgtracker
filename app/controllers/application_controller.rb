class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  prepend_before_filter :save_login_target
  prepend_before_filter :save_logout_target

private
  def require_current_user
    clear_logout_target
    redirect_to new_user_session_url unless current_user
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def save_login_target
    session[:login_target]  = request.fullpath
  end

  def clear_login_target
    session.delete(:login_target)
  end

  def save_logout_target
    session[:logout_target] = request.fullpath
  end

  def clear_logout_target
    session.delete(:logout_target)
  end

  def redirect_to_login_target
    target = session.delete(:login_target) || root_url
    redirect_to target
  end

  def redirect_to_logout_target
    target = session.delete(:logout_target) || root_url
    redirect_to target
  end
end
