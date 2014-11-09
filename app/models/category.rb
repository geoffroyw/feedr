class Category < ActiveRecord::Base

  belongs_to :user
  belongs_to :user_feed

  validates :name, :presence => true

end
