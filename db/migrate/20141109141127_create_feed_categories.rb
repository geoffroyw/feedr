class CreateFeedCategories < ActiveRecord::Migration
  def change
    create_table :feed_categories do |t|
      t.string :name
      t.integer :user_id
      t.integer :user_feed_id
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
  end
end
