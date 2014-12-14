require 'spec_helper'

describe Category do
  it{should belong_to(:user)}
  it{should have_many(:user_feed_categories)}
  it{should have_many(:user_feeds).through(:user_feed_categories)}

  it{should validate_presence_of :name}


end
