class AddEnclosureUrlToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :enclosure_url, :string
  end
end
