class DeleteCategoryIdFromUserFeed < ActiveRecord::Migration
  def change
    remove_column :user_feeds, :category_id
  end
end
