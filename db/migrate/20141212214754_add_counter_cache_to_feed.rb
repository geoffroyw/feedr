class AddCounterCacheToFeed < ActiveRecord::Migration
  def up
    add_column :feeds, :item_count, :integer, :default => 0

    Feed.reset_column_information

    Feed.all.each do |feed|
      Feed.update_counters feed.id, :item_count => feed.items.count
    end
  end

  def down
    remove_column :feeds, :item_count
  end
end
