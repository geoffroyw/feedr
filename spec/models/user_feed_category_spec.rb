require 'spec_helper'

describe UserFeedCategory do

  it{should belong_to :user_feed}
  it{should belong_to :category}

  it{should validate_presence_of :user_feed}
  it{should validate_presence_of :category}
end
