class UserFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  has_many :categories

  validates :user, :presence => true
  validates :feed, :presence => true

  validates :name, :presence => true

  before_validation :set_default_name

  scope :of_user , -> (user) {where('user_id' =>  user.id)}



  def unread_item_count
    self.feed.items.count-self.feed.items.read_by(self.user).count
  end

  def read_item_count
    self.feed.items.count-self.feed.items.unread_by(self.user).count
  end



  private
  def set_default_name
    self.name = self.feed.name if !self.feed.nil? && self.name.blank? && self.id.nil?
  end

end
