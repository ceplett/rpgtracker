require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'should redirect to login if no user logged in' do
    get :show
    assert_redirected_to new_user_session_url
    assert_nil assigns['user']
  end

  test 'should get show if user is logged in' do
    user = Factory(:user)
    sign_in user
    get :show
    assert_response :success
    assert_equal user, assigns['user']
  end

end
