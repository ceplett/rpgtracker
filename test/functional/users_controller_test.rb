require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def test_show_succeeds
    get :show
    assert_response :success
    assert_nil assigns['user']
  end

end
