class Category < ActiveRecord::Base

  belongs_to :user
  has_many :user_feeds

  accepts_nested_attributes_for :user_feeds

  validates :name, :presence => true

  acts_as_nested_set

end
