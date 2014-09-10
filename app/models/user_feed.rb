class UserFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  validates :user, :presence => true
  validates :feed, :presence => true
end
