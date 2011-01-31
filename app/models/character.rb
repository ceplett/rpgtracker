class Character < ActiveRecord::Base
  belongs_to :player, :class_name => 'User'
  belongs_to :campaign

  has_attached_file :token, :styles => {:small => '64x64>'}
  has_attached_file :portrait
end
