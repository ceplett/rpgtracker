class UsersController < ApplicationController
  before_filter :authenticate_user!

  respond_to  :html

  def show
    @user = current_user
    respond_with @user
  end

end
