require 'spec_helper'

describe Feed do
  it{should validate_presence_of :name}
  it{should validate_presence_of :url}
  it{should validate_uniqueness_of(:url).case_insensitive}


  it{should have_many :feed_items}
  it{should have_many :user_feeds}
  it{should have_many(:users).through :user_feeds }
end
