class UserSessionsController < ApplicationController
  skip_before_filter  :save_login_target
  skip_before_filter  :save_logout_target

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to_login_target
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to_logout_target
  end

end
