class Feed < ActiveRecord::Base

  flux_url_regexp = /\A((https?):\/\/|(www)\.)[a-z0-9-]+(\.[a-z0-9-]+)+([\/?].*)?\z/i
  validates :url, presence: true
  validates :name, presence: true
  validates :url, uniqueness: {case_sensitive: false}
  validates :url, format: {with: flux_url_regexp}

  has_many :items
  has_many :users, :through => :user_feeds
  has_many :user_feeds

  before_validation :fetch_name

  def fetch_name
    feed =  Feedjira::Feed.fetch_and_parse url
    if feed.title.nil?
      self.name = self.url
    else
      self.name = feed.title
    end
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


  def custom_name(user)
    if self.user_feeds.of_user(user).first.nil?
      self.name
    else
      self.user_feeds.of_user(user).first.name
    end
  end

  #handle_asynchronously :fetch_items
end
