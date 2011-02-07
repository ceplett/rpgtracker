class Invitation < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :player,   :class_name => 'User'

  validates :campaign, :presence => true
  validates :email, :presence => true

  before_save :assign_player

private

  def assign_player
    return unless player.blank?
    self.player = User.find_by_email(self.email)
  end

end
