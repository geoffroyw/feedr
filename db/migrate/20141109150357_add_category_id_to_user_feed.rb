class AddCategoryIdToUserFeed < ActiveRecord::Migration
  def change
    add_column :user_feeds, :category_id, :integer
  end
end
