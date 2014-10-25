class Item < ActiveRecord::Base

  url_regex = /\A((https?):\/\/|(www)\.)[a-z0-9-]+(\.[a-z0-9-]+)+([\/?].*)?\z/i
  validates :url, :presence => true
  validates :url, :format => {with: url_regex}
  validates :title, :presence => true

  belongs_to :feed
  has_many :user_items

  scope :read_by , -> (user) {where('id' =>  user.user_items.map{|user_item| user_item.item_id})}

  scope :unread_by, -> (user) {where('id not in (?)', user.user_items.map{|user_item| user_item.item_id})}



  default_scope {order ('published_at DESC')}
end
