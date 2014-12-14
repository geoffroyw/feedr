module CategoriesHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper

  # Like #nested_set_options helper but with only one DB query
  #
  # Returns options for select.
  # You can exclude some items from the tree.
  # You can pass a block receiving an item and returning the string displayed in the select.
  #
  # == Params
  # * +class_or_item+ - Class name or top level times
  # * +mover+ - The item that is being move, used to exclude impossible moves
  # * +&block+ - a block that will be used to display: { |item| ... item.name }
  #
  # == Usage
  #
  # <%= f.select :parent_id, nested_tree_options(Category, @category) {|i, level|
  # "#{'-' * level} #{i.name}"
  # }) %>
  #
  def nested_tree_options(class_or_item, mover = nil)
    result = []
    items = Array( class_or_item.is_a?(Class) ? class_or_item.roots : class_or_item )
    items.each do |item|
      result << [yield(item, 0), item.id]
      unless item.leaf?
        item.class.each_with_level(item.descendants) do |i, level|
          if mover.nil? || mover.new_record? || mover.move_possible?(i)
            result << [yield(i, level), i.id]
          end
        end
      end
    end
    result
  end

  def create_category_navigation_tree(categories)
    categories = Array(categories.is_a?(Class) ? categories.siblings : categories)
    return unless current = categories.shift
    parent_id = current.parent_id
    haml_tag 'ol.categories' do
      while current && current.parent_id == parent_id do
        haml_tag :li do
          haml_tag :a, current.name, :href=> edit_category_path(current)
          unless current.user_feeds.nil?
            haml_tag :ul do
              current.user_feeds.each do |f|
                haml_tag :li do
                  haml_tag :a, f.name, :href => feed_path(f)
                end
              end
            end
          end
          if current.rgt > current.lft + 1
            create_category_navigation_tree(current.children)
          end
          current = categories.shift
        end
      end
    end
    current
  end

  def create_sidebar(categories)
    categories = Array(categories.is_a?(Class) ? categories.siblings : categories)
    return unless current = categories.shift
    parent_id = current.parent_id
    haml_tag 'ul.categories' do
      while current && current.parent_id == parent_id do
        haml_tag :li do
          haml_tag :a, :href=> category_path(current) do
            haml_concat current.name
            haml_tag :a, :href => edit_category_path(current) do
              haml_tag :span, :class => 'glyphicon glyphicon-pencil'
            end
          end
          unless current.user_feeds.nil?
            haml_tag :ul do
              current.user_feeds.each do |f|
                haml_tag :li do
                  haml_tag :a, :href => feed_path(f) do
                    if f.unread_item_count > 0
                      haml_tag :strong do
                        haml_concat f.name
                        haml_tag :span, f.unread_item_count, :class => 'badge', 'data-type' => 'feed', 'data-badge-for' => f.id
                      end
                    else
                      haml_concat f.name
                      haml_tag :span, f.unread_item_count, :class => 'badge', 'data-type' => 'feed', 'data-badge-for' => f.id
                    end
                  end
                  haml_tag :a, :href => feed_path(f) do
                    haml_tag :span, :class => 'glyphicon glyphicon-pencil'
                  end
                end
              end
            end
          end
          if current.rgt > current.lft + 1
            create_sidebar(current.children)
          end
          current = categories.shift
        end
      end
    end
    current
  end

end
