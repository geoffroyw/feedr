class FeedItem < ActiveRecord::Base

  url_regex = /\A((https?):\/\/|(www)\.)[a-z0-9-]+(\.[a-z0-9-]+)+([\/?].*)?\z/i
  validates :url, :presence => true
  validates :url, :format => {with: url_regex}
  validates :title, :presence => true
  validates :description, :presence => true

  belongs_to :feed, :polymorphic => true
end
