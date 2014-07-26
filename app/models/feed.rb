class Feed < ActiveRecord::Base

  flux_url_regexp = /\A((https?):\/\/|(www)\.)[a-z0-9-]+(\.[a-z0-9-]+)+([\/?].*)?\z/i
  validates :url, presence: true
  validates :url, uniqueness: {case_sensitive: false}
  validates :url, format: {with: flux_url_regexp}
  validates :name,presence: true

  has_many :feed_items, :foreign_key => 'feed_id'



  def fetch_items
    feed = Feedjira::Feed.fetch_and_parse url
    feed.entries.each do |entry|
      feed_item = FeedItem.find_or_create_by(url: entry.url)
      feed_item.feed_id = self.id
      feed_item.url  = entry.url
      feed_item.title = entry.title
      feed_item.description = entry.summary
      feed_item.published_at = entry.published
      feed_item.save
    end

  end
  #handle_asynchronously :fetch_items
end
