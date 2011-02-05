require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  test 'new should redirect to login if not logged in' do
    get :new
    assert_redirected_to new_user_session_url
  end

  test 'new should succeed if logged in' do
    user = Factory(:user)
    sign_in user
    get :new
    assert_response :success
  end

  test 'create should redirect to login if not logged in' do
    camp = Factory(:campaign)
    assert_no_difference 'Campaign.count' do
      post :create, :campaign => camp.attributes
    end
  end

  test 'should create campaign' do
    user = Factory(:user)
    camp = Factory.build(:campaign, :gm => nil)
    sign_in user
    assert_difference 'Campaign.count', 1 do
      post :create, :campaign => camp.attributes
    end
    actual = assigns(:campaign)
    assert_not_nil actual
    assert_equal user, actual.gm
    assert_redirected_to campaign_path(actual)
  end

  test 'show should redirect if not logged in' do
    camp = Factory(:campaign)
    get :show, :id => camp.to_param
    assert_redirected_to new_user_session_url
  end

  test 'should get show if logged in' do
    expected = Factory(:campaign)
    sign_in Factory(:user)
    get :show, :id => expected.to_param
    assert_response :success
    actual = assigns(:campaign)
    assert_equal expected, actual
  end

  test 'edit should redirect if not logged in' do
    camp = Factory(:campaign)
    get :edit, :id => camp.to_param
    assert_redirected_to new_user_session_url
  end

  test 'edit should be unauthorized if non-gm is logged in' do
    camp = Factory(:campaign)
    sign_in Factory(:user)
    get :edit, :id => camp.to_param
    assert_response :unauthorized
  end

  test 'should get edit if gm logged in' do
    camp = Factory(:campaign)
    sign_in camp.gm
    get :edit, :id => camp.to_param
    assert_response :success
    actual = assigns(:campaign)
    assert_equal camp, actual
  end

  test 'create should redirect if not logged in' do
    camp = Factory(:campaign)
    changed_attr = camp.attributes.dup
    changed_attr['title'] = 'New Title'
    put :update, :id => camp.to_param, :campaign => changed_attr
    assert_redirected_to new_user_session_url
  end

  test 'create should be unauthorized if non-gm is logged in' do
    camp = Factory(:campaign)
    sign_in Factory(:user)
    changed_attr = camp.attributes.dup
    changed_attr['title'] = 'New Title'
    put :update, :id => camp.to_param, :campaign => changed_attr
    assert_response :unauthorized
  end

  test 'should update campaign if gm logged in' do
    camp = Factory(:campaign)
    sign_in camp.gm
    changed_attr = camp.attributes.dup
    changed_attr['title'] = 'New Title'
    put :update, :id => camp.to_param, :campaign => changed_attr
    actual = assigns(:campaign)
    assert_not_nil actual
    assert_equal 'New Title', actual.title
    assert_redirected_to campaign_url(actual)
  end

end
