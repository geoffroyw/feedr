class CreateUserFeedCategories < ActiveRecord::Migration
  def change
    create_table :user_feed_categories do |t|
      t.integer :user_feed_id
      t.integer :category_id

      t.timestamps
    end
  end
end
