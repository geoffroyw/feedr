class Feed < ActiveRecord::Base

  flux_url_regexp = /\A((https?):\/\/|(www)\.)[a-z0-9-]+(\.[a-z0-9-]+)+([\/?].*)?\z/i
  validates :url, presence: true
  validates :url, uniqueness: {case_sensitive: false}
  validates :url, format: {with: flux_url_regexp}
  validates :name,presence: true

  has_many :feed_items, :foreign_key => 'feed_id'
end
