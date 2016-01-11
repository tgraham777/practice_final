require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user

  validates :url, :url => true

  scope :by_user, -> (user_id) { where(user_id: user_id) }
end
