require 'test_helper'

class CharacterTest < ActiveSupport::TestCase

  def test_player
    u = Factory(:user)
    assert_equal 0, u.characters.count

    assert_difference 'Character.count', 1 do
      c = u.characters.create(:name => 'Booyah McGee', :campaign => Factory(:campaign))
      assert c.valid?
      assert_equal 1, u.characters.count
      assert_equal c, u.characters.first
      assert_equal u, c.player
    end
  end

  def test_campaign
    camp = Factory(:campaign)
    assert_equal 0, camp.characters.count

    assert_difference 'Character.count', 1 do
      c = camp.characters.create(:name => 'Booyah McGee', :player => Factory(:user))
      assert c.valid?
      assert_equal 1, camp.characters.count
      assert_equal c, camp.characters.first
      assert_equal camp, c.campaign
    end
  end

end
