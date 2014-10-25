class RenameFeedItemsToItem < ActiveRecord::Migration
  def change
    rename_table :feed_items, :items
  end
end
