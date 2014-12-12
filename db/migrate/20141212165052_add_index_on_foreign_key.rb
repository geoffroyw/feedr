class AddIndexOnForeignKey < ActiveRecord::Migration
  def change
    add_index :items, :feed_id
    add_index :user_feeds, :feed_id
    add_index :user_feeds, :user_id
    add_index :user_items, :user_id
    add_index :user_items, :item_id
  end
end
