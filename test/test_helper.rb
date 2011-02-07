ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
end

class ActionController::TestCase
  include Devise::TestHelpers

  def set_current_user(user=nil)
    user ||= Factory(:user)
    sign_in user
    user
  end
end
