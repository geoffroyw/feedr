class ChangeDescriptionTypeToTextInFeedItem < ActiveRecord::Migration
  def up
    change_column :feed_items, :description, :text
  end
  def down
    change_column :feed_items, :description, :string
  end
end
