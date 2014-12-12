class AddFeedIdToUserItem < ActiveRecord::Migration
  def up
    add_column :user_items, :feed_id, :integer
    add_index :user_items, :feed_id

    UserItem.reset_column_information

    UserItem.all.each do |user_item|
      user_item.feed_id = user_item.item.feed_id
      user_item.save
    end

  end

  def down
    remove_index :user_items, :feed_id
    remove_column :user_items, :feed_id
  end
end