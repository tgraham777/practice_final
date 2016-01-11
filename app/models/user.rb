class User < ActiveRecord::Base
  has_many :links
  has_secure_password

  validates_presence_of :name
  validates_presence_of :password
  validates_confirmation_of :password
  validates_presence_of :email
  validates_uniqueness_of :email
end
