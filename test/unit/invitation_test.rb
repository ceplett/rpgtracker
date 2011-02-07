require 'test_helper'

class InvitationTest < ActiveSupport::TestCase

  test 'validations' do
    invite = Factory.build(:invitation, :campaign => nil, :email => nil)
    assert invite.invalid?
    assert !invite.errors[:campaign].blank?
    assert !invite.errors[:email].blank?

    invite = Factory.build(:invitation)
    assert invite.valid?
    assert invite.errors.blank?
  end

  test 'player gets assigned' do
    player = Factory(:user)
    invite = Factory(:invitation, :email => player.email)
    assert_equal player, invite.player
  end

  test 'player does not get assigned' do
    player = Factory(:user)
    invite = Factory(:invitation)
    assert_nil invite.player
  end

end
