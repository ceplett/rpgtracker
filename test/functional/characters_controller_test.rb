require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  setup do
    @campaign = Factory(:campaign)
  end

  test 'new should redirect to login if not logged in' do
    get :new, :campaign_id => @campaign.to_param
    assert_redirected_to new_user_session_url
  end

  test 'new should not be found for non-existent campaign' do
    set_current_user
    get :new, :campaign_id => 'nosir'
    assert_response :not_found
  end

  test 'new should succeed if logged in' do
    user = set_current_user
    get :new, :campaign_id => @campaign.to_param
    assert_response :success
    assert assigns(:character)
    assert_equal user, assigns(:character).player
    assert_equal @campaign, assigns(:character).campaign
  end

  test 'create should redirect to login if not logged in' do
    assert_no_difference 'Character.count' do
      post :create, :campaign_id => @campaign.to_param, :character => valid_character_attributes
    end
    assert_redirected_to new_user_session_url
  end

  test 'create should not be found for non-existent campaign' do
    set_current_user
    assert_no_difference 'Character.count' do
      post :create, :campaign_id => 'nosir', :character => valid_character_attributes
    end
    assert_response :not_found
  end

  test 'should create character with valid attributes' do
    user = set_current_user
    assert_difference 'Character.count', 1 do
      post :create, :campaign_id => @campaign.to_param, :character => valid_character_attributes
    end
    assert_not_nil assigns(:character)
    assert assigns(:character).valid?
    assert_equal user, assigns(:character).player
    assert_equal @campaign, assigns(:character).campaign
    assert_redirected_to campaign_character_path(@campaign, assigns(:character))
  end

  test 'should not create character with invalid attributes' do
    user = set_current_user
    assert_no_difference 'Character.count' do
      post :create, :campaign_id => @campaign.to_param, :character => invalid_character_attributes
    end
    assert_not_nil assigns(:character)
    assert assigns(:character).invalid?
    assert_equal user, assigns(:character).player
    assert_equal @campaign, assigns(:character).campaign
    assert_response :success
    assert_template :new
  end

  # show and edit have essentially the same behavior, so let's DRY up these tests
  [:show, :edit].each do |action|
    test "#{action} should redirect if not logged in" do
      character = @campaign.characters.create valid_character_attributes.merge(:player => Factory(:user))
      get action, :campaign_id => @campaign.to_param, :id => character.to_param
      assert_redirected_to new_user_session_url
    end

    test "#{action} should not be found for non-existent campaign" do
      set_current_user
      character = Factory(:character)
      get action, :campaign_id => 'nosir', :id => character.to_param
      assert_response :not_found
    end

    test "#{action} should not be found for wrong campaign" do
      set_current_user
      character = Factory(:character)
      get action, :campaign_id => @campaign.to_param, :id => character.to_param
      assert_response :not_found
    end

    test "#{action} should not be found for non-existent character" do
      set_current_user
      get action, :campaign_id => @campaign.to_param, :id => 'nosir'
      assert_response :not_found
    end

    test "should get #{action}" do
      user = set_current_user
      character = @campaign.characters.create valid_character_attributes.merge(:player => user)
      get action, :campaign_id => @campaign.to_param, :id => character.to_param
      assert_response :success
      assert_equal character, assigns(:character)
    end
  end

  test "edit should be unauthorized" do
    user = set_current_user
    character = @campaign.characters.create valid_character_attributes.merge(:player => Factory(:user))
    get :edit, :campaign_id => @campaign.to_param, :id => character.to_param
    assert_response :unauthorized
  end

private

  def valid_character_attributes
    {
      :name => 'Wizard McZappypants'
    }
  end

  def invalid_character_attributes
    {
      :name => ''
    }
  end
end
