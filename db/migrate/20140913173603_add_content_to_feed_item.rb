class AddContentToFeedItem < ActiveRecord::Migration
  def change
    add_column :feed_items, :content, :string
  end
end
