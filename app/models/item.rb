class Item < ActiveRecord::Base

  url_regex = /\A((https?):\/\/|(www)\.)[a-z0-9-]+(\.[a-z0-9-]+)+([\/?].*)?\z/i
  validates :url, :presence => true
  validates :url, :format => {with: url_regex}
  validates :title, :presence => true
  validates :view_count, numericality: { only_integer: true, :greater_than_or_equal_to => 0}, :presence => true
  validates :read_count, numericality: { only_integer: true, :greater_than_or_equal_to => 0}, :presence => true

  belongs_to :feed, counter_cache: :item_count
  has_many :user_items

  scope :read_by , -> (user) {where('id' =>  user.user_items.map{|user_item| user_item.item_id})}

  scope :unread_by, -> (user) {where('id not in (?)', user.user_items.map{|user_item| user_item.item_id})}

  before_validation :set_count_to_zero

  default_scope {order ("#{table_name}.published_at DESC, #{table_name}.id DESC")}

  private
  def set_count_to_zero
    self.view_count = 0 if self.view_count.nil?
    self.read_count = 0 if self.read_count.nil?
  end

end
