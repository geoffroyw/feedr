class FeedItem < ActiveRecord::Base

  url_regex = /\A((https?):\/\/|(www)\.)[a-z0-9-]+(\.[a-z0-9-]+)+([\/?].*)?\z/i
  validates :url, :presence => true
  validates :url, :format => {with: url_regex}
  validates :title, :presence => true

  belongs_to :feed
  has_many :user_items, :foreign_key => 'item_id'

  scope :with_user , -> (user) {where('id' => user.user_items.map{|i| i.id})}



  default_scope {order ('published_at DESC')}
end
