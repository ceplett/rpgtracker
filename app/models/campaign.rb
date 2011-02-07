class Campaign < ActiveRecord::Base
  belongs_to  :gm, :class_name => 'User'
  has_many    :characters
  has_many    :players, :through => :characters

  validates   :gm, :presence => true
  validates   :title, :presence => true
end
