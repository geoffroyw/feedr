class AddColorToCategory < ActiveRecord::Migration
  def up
    add_column :categories, :color, :string

    Category.all.each do |cat|
      cat.set_color
      cat.save!
    end

  end

  def down
    remove_column :categories, :color
  end
end


