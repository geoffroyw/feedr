class AddNameToUserFeeds < ActiveRecord::Migration
  def change
    add_column :user_feeds, :name, :text
  end
end
