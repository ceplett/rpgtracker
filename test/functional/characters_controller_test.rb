require 'test_helper'

class CharactersControllerTest < ActionController::TestCase

  test 'index should succeed without any characters' do
    get :index
    assert_response :success
    assert_equal 0, assigns['characters'].size
  end

  test 'index should succeed with a character' do
    char = Factory(:character)
    get :index
    assert_response :success
    assert_equal 1, assigns['characters'].size
    assert_equal char, assigns['characters'].first
  end

  test 'show should succeed' do
    expected = Factory(:character)
    get :show, :id => expected.id
    assert_response :success
    assert_template 'show'
    assert_equal expected, assigns['character']
  end

  test 'new should succeed' do
    get :new
    assert_response :success
    assert_template 'new'
    assert assigns['character'].is_a?(Character)
    assert_nil assigns['character'].name
  end

  test 'create should succeed with uploaded file' do
    assert_difference 'Character.count', 1 do
      post :create, :character => {
        :sheet => fixture_file_upload('Immilzin.dnd4e')
      }
    end
    assert assigns['character'].is_a?(Character)
    assert_redirected_to character_path(assigns['character'])
    assert_equal 'Immilzin', assigns['character'].name
  end

  test 'create should not succeed without uploaded file' do
    assert_no_difference 'Character.count' do
      post :create, :character => {:sheet => nil}
    end
    assert assigns['character'].is_a?(Character)
    assert_response :success
    assert_template 'new'
  end

  test 'edit should succeed' do
    expected = Factory(:character)
    get :edit, :id => expected.id
    assert_response :success
    assert_template 'edit'
    assert_equal expected, assigns['character']
  end

  test 'update should succeed with new file' do
    char = Factory(:character)
    assert_equal 'Immilzin', char.name
    put :update, {
      :id => char.id,
      :sheet => fixture_file_upload('Bronwyn.dnd4e')
    }
    assert_redirected_to character_path(assigns['character'])
    assert_equal 'Bronwyn', assigns['character'].name
  end

  test 'destroy should succeed' do
    char = Factory(:character)
    assert_difference 'Character.count', -1 do
      delete :destroy, :id => char.id
    end
    assert_redirected_to characters_path
  end

end
