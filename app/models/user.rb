class User < ActiveRecord::Base
  has_many :campaigns
  has_many :characters

  validates :name,  :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
end
