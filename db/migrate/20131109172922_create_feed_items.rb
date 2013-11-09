class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.integer :feed_id
      t.string :url
      t.string :description
      t.string :title
      t.datetime :published_at

      t.timestamps
    end
  end
end
