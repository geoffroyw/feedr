require 'spec_helper'

describe FeedCategory do
  it{should belong_to(:user)}
  it{should belong_to(:user_feed)}

  it{should validate_presence_of :name}


end
