class UserFeedCategory < ActiveRecord::Base
  belongs_to :user_feed
  belongs_to :category

  validates :user_feed, :presence => true
  validates :category, :presence => true
end
