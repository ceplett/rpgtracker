class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

private

  def require_current_user
    redirect_to new_user_url unless current_user
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.first
  end

end
