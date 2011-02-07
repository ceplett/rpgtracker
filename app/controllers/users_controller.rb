class UsersController < ApplicationController
  respond_to  :html

  before_filter :authenticate_user!

  def show
    @user = current_user
    respond_with @user
  end

end
