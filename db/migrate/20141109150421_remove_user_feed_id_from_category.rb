class RemoveUserFeedIdFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :user_feed_id
  end
end
