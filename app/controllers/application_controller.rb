class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def render_not_found(status=:not_found)
    if request.xhr?
      render :nothing => true, :status => status
    else
      render :file => File.join(::Rails.root.to_s, 'public', '404.html'), :layout => false, :status => status
    end
  end

end
