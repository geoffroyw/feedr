class Category < ActiveRecord::Base

  belongs_to :user
  has_many :user_feed_categories
  has_many :user_feeds, :through => :user_feed_categories

  validates :name, :presence => true

  acts_as_nested_set

  before_save :set_color


  def set_color
    hash = 0
    self.name.split('').map{|c| hash += c.ord}

    hash = hash % 360

    self.color = Color::HSL.new(hash, 70, 40).html

  end

end
