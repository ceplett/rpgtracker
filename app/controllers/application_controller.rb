class ApplicationController < ActionController::Base
  protect_from_forgery

  prepend_before_filter :store_login_targets

private
  def render_not_found(status=:not_found)
    if request.xhr?
      render :nothing => true, :status => status
    else
      render :file => File.join(::Rails.root.to_s, 'public', '404.html'), :layout => false, :status => status
    end
  end

  alias_method :devise_authenticate_user!, :authenticate_user!
  def authenticate_user!
    session.delete(:logout_target)
    devise_authenticate_user!
  end

  def store_login_targets
    return if devise_controller?
    session[:login_target]  = request.fullpath
    session[:logout_target] = request.fullpath
  end

  def after_sign_in_path_for(resource)
    logger.debug 'after_sign_in_path_for'
    session.delete(:login_target) || root_url
  end

  def after_sign_out_path_for(resource)
    logger.debug 'after_sign_out_path_for'
    session.delete(:logout_target) || root_url
  end

end
