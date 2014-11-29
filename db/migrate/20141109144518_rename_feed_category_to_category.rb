class RenameFeedCategoryToCategory < ActiveRecord::Migration
  def change
    rename_table :feed_categories, :categories
  end
end
