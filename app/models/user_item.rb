class UserItem < ActiveRecord::Base

  belongs_to :user
  belongs_to :item, :class_name=> 'FeedItem'

  validates :user, :presence => true
  validates :item, :presence => true
end
