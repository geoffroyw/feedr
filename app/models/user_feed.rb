class UserFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  validates :user, :presence => true
  validates :feed, :presence => true

  validates :name, :presence => true

  after_create :set_default_name

  private
  def set_default_name
    self.name = self.feed.name
  end

end
