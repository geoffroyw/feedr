class ChangeTypeOfItemEnclosureUrlAndUrlToString < ActiveRecord::Migration
  def up
    change_column :items, :enclosure_url, :text
    change_column :items, :url, :text
  end
  def down
    change_column :items, :enclosure_url, :string
    change_column :items, :url, :string
  end
end
