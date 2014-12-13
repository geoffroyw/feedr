class UserItem < ActiveRecord::Base

  belongs_to :user
  belongs_to :item
  belongs_to :feed

  validates :user, :presence => true
  validates :item, :presence => true
  validates :feed, :presence => true

  scope :of_feed_and_user , -> (feed_id, user_id) {where('feed_id = ? and user_id = ? ', feed_id, user_id)}
end
