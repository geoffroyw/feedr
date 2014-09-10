require 'spec_helper'

describe Feed do
  it{should validate_presence_of :url}
  #it{should validate_uniqueness_of(:url).case_insensitive}

  it{should have_many(:items).with_foreign_key('feed_id').class_name('FeedItem')}
  it{should have_many(:user_feeds).with_foreign_key('feed_id')}
  it{should have_many(:users).through :user_feeds }

  it { should callback(:fetch_name).before(:save)}
end
