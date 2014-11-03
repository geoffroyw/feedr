class AddViewCountAndReadCountToItem < ActiveRecord::Migration
  def change
    add_column :items, :view_count, :integer
    add_column :items, :read_count, :integer
  end
end
