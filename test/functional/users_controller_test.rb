require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'should redirect show if no user logged in' do
    get :show
    assert_redirected_to new_user_url
    assert_nil assigns['user']
  end

  test 'should get show if user is logged in' do
    user = Factory(:user)
    get :show
    assert_response :success
    assert_equal user, assigns['user']
  end

end
