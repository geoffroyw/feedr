namespace :feed do
  task :fetch_new_items => :environment do

    Feed.where('updated_at < ?', 1.hour.ago).each do |feed|
      feed.fetch_items
      feed.updated_at = Time.now
      feed.save
    end

  end

end
