require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  setup do
    @login_target = '/login/target'
    session[:login_target]  = @login_target
    @logout_target = '/logout/target'
    session[:logout_target] = @logout_target
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create user session" do
    user = Factory(:user)
    post :create, :user_session => { :email => user.email, :password => user.password }
    assert user_session = UserSession.find
    assert_equal user, user_session.user
    assert_redirected_to @login_target
  end
  
  test "should destroy user session" do
    delete :destroy
    assert_nil UserSession.find
    assert_redirected_to @logout_target
  end

end
