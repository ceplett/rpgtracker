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
    assert_no_difference 'Campaign.count' do
      post :create, :campaign => valid_campaign_attributes
    end
  end

  test 'should create campaign' do
    user = Factory(:user)
    sign_in user
    assert_difference 'Campaign.count', 1 do
      post :create, :campaign => valid_campaign_attributes
    end
    actual = assigns(:campaign)
    assert_not_nil actual
    assert_equal user, actual.gm
    assert_redirected_to campaign_path(actual)
  end

  test 'should not create campaign with invalid attributes' do
    user = Factory(:user)
    sign_in user
    assert_no_difference 'Campaign.count' do
      post :create, :campaign => invalid_campaign_attributes
    end
    actual = assigns(:campaign)
    assert_not_nil actual
    assert actual.invalid?
    assert_equal user, actual.gm
    assert_response :success
    assert_template :new
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
    put :update, :id => camp.to_param, :campaign => valid_campaign_attributes
    assert_redirected_to new_user_session_url
  end

  test 'create should be unauthorized if non-gm is logged in' do
    camp = Factory(:campaign)
    sign_in Factory(:user)
    put :update, :id => camp.to_param, :campaign => valid_campaign_attributes
    assert_response :unauthorized
  end

  test 'should update campaign if gm logged in' do
    camp = Factory(:campaign)
    sign_in camp.gm
    put :update, :id => camp.to_param, :campaign => valid_campaign_attributes
    actual = assigns(:campaign)
    assert_not_nil actual
    assert_equal 'This is a test', actual.title
    assert_redirected_to campaign_url(actual)
  end

  test 'should not update campaign with invalid attributes' do
    camp = Factory(:campaign)
    sign_in camp.gm
    put :update, :id => camp.to_param, :campaign => invalid_campaign_attributes
    actual = assigns(:campaign)
    assert_not_nil actual
    assert actual.invalid?
    assert !actual.errors[:title].blank?
    assert_response :success
    assert_template :edit
  end

private

  def valid_campaign_attributes
    {
      :title => 'This is a test',
      :description => 'Now is the winter of our discontent'
    }
  end

  def invalid_campaign_attributes
    {
      :title => '', # the title can't be blank!
      :description => 'Now is the winter of our discontent'
    }
  end

end
