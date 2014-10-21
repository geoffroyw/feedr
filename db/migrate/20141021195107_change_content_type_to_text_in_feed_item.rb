class ChangeContentTypeToTextInFeedItem < ActiveRecord::Migration
  def up
    change_column :feed_items, :content, :text
  end
  def down
    change_column :feed_items, :content, :string
  end
end
