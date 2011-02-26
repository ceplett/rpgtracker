ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  def fixture_file(file_name)
    Rails.root.join('test/fixtures', file_name)
  end
end

class ActionController::TestCase
  include Devise::TestHelpers

  def set_current_user(user=nil)
    user ||= Factory(:user)
    sign_in user
    user
  end
end
