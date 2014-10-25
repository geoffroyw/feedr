class Feed < ActiveRecord::Base

  flux_url_regexp = /\A((https?):\/\/|(www)\.)[a-z0-9-]+(\.[a-z0-9-]+)+([\/?].*)?\z/i
  validates :url, presence: true
  validates :url, uniqueness: {case_sensitive: false}
  validates :url, format: {with: flux_url_regexp}

  has_many :items
  has_many :users, :through => :user_feeds
  has_many :user_feeds

  before_save :fetch_name

  def fetch_name
    feed =  Feedjira::Feed.fetch_and_parse url
    self.name = feed.title
  end


  def fetch_items
    feed = Feedjira::Feed.fetch_and_parse url
    feed.entries.each do |entry|
      feed_item = Item.find_or_create_by(url: entry.url)
      feed_item.feed_id = self.id
      feed_item.url  = entry.url
      feed_item.title = entry.title.sanitize unless entry.title.nil?
      feed_item.description = entry.summary.sanitize unless entry.summary.nil?
      feed_item.content = entry.content
      if entry.respond_to? :enclosure_url
        feed_item.enclosure_url = entry.enclosure_url
      end
      feed_item.published_at = entry.published
      feed_item.save
    end

  end


  def unread_item_count(user)
    self.items.count-self.items.read_by(user).count
  end

  def read_item_count(user)
    self.items.count-self.items.unread_by(user).count
  end

  #handle_asynchronously :fetch_items
end
