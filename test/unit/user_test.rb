require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_validations
    u = Factory.build(:user)
    assert u.valid?

    u = Factory.build(:user, :name => nil, :email => nil)
    assert u.invalid?
    assert !u.errors[:name].blank?
    assert !u.errors[:email].blank?
  end

  def test_campaigns
    u = Factory(:user)
    assert_equal 0, u.campaigns.count

    assert_difference 'Campaign.count', 1 do
      c = u.campaigns.create(:title => 'foobar', :description => 'blah')
      assert_equal 1, u.campaigns.count
      assert_equal c, u.campaigns.first
      assert_equal u, c.gm
    end
  end

  def test_characters
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
end
