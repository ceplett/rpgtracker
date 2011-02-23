class Campaign < ActiveRecord::Base
  belongs_to  :gm, :class_name => 'User'
  has_many    :characters
  has_many    :players, :through => :characters
  has_many    :invitations

  validates   :gm, :presence => true
  validates   :title, :presence => true

  def gm?(user)
    user == self.gm
  end

  def to_s
    title
  end
end
