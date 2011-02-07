require 'test_helper'

class CampaignTest < ActiveSupport::TestCase

  def test_title
    u = Factory.build(:campaign, :title => nil)
    assert u.invalid?
    assert !u.errors[:title].blank?

    u.title = 'This is a test'
    assert u.valid?
    assert u.errors[:title].blank?
  end

  def test_gm
    u = Factory(:user)
    assert_equal 0, u.campaigns.count

    assert_difference 'Campaign.count', 1 do
      c = u.campaigns.create(:title => 'foobar', :description => 'blah')
      assert_equal 1, u.campaigns.count
      assert_equal c, u.campaigns.first
      assert_equal u, c.gm
    end
  end

  def test_characters_and_players
    camp = Factory(:campaign)
    assert_equal 0, camp.characters.count

    assert_difference 'Character.count', 1 do
      c = camp.characters.create(:name => 'Booyah McGee', :player => Factory(:user))
      assert c.valid?
      assert_equal 1, camp.characters.count
      assert_equal c, camp.characters.first
      assert_equal camp, c.campaign
      assert_equal 1, camp.players.count
      assert_equal c.player, camp.players.first
    end
  end

end
