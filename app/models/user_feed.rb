class UserFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  validates :user, :presence => true
  validates :feed, :presence => true

  validates :name, :presence => true

  before_validation :set_default_name

  scope :of_user , -> (user) {where('user_id' =>  user.id)}

  private
  def set_default_name
    self.name = self.feed.name if !self.feed.nil? && self.name.blank?
  end

end
