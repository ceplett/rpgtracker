require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  setup do
    @campaign = Factory(:campaign)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campaign" do
    assert_difference('Campaign.count') do
      post :create, :campaign => @campaign.attributes
    end

    assert_redirected_to campaign_path(assigns(:campaign))
  end

  test "should show campaign" do
    get :show, :id => @campaign.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @campaign.to_param
    assert_response :success
  end

  test "should update campaign" do
    put :update, :id => @campaign.to_param, :campaign => @campaign.attributes
    assert_redirected_to campaign_path(assigns(:campaign))
  end

end
