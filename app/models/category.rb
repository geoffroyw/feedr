class Category < ActiveRecord::Base

  belongs_to :user
  has_many :user_feed_categories
  has_many :user_feeds, :through => :user_feed_categories

  validates :name, :presence => true

  acts_as_nested_set

end
