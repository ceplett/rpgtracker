class User < ActiveRecord::Base
  has_many :campaigns,  :foreign_key => :gm_id
  has_many :characters, :foreign_key => :player_id

  validates :name,  :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
end
