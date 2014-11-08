namespace :migrator do
  task :set_default_feed_name => :environment do

    UserFeed.all.each do |uf|
      uf.name =  uf.feed.name
      uf.save!
    end

  end

end
