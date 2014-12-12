namespace :migrator do
  task :set_default_feed_name => :environment do

    UserFeed.all.each do |uf|
      uf.name =  uf.feed.name
      uf.save!
    end

  end

  task :clean_duplicate_user_items => :environment do

    UserItem.all.each do |user_item|
      UserItem.where('user_id = ? and feed_id = ? and item_id = ? and id < ?', user_item.user_id, user_item.feed_id, user_item.item_id, user_item.id).each do |ui|
        ui.destroy!
      end
    end


  end

end
