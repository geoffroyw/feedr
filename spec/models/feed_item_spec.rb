require 'spec_helper'

describe FeedItem do
  it{should validate_presence_of :url}
  it{should validate_presence_of :title}
  it{should validate_presence_of :description}
  it{should belong_to :feed}
end
