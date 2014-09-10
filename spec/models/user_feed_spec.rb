require 'spec_helper'

describe UserFeed do
  it{should validate_presence_of :user}
  it{should validate_presence_of :feed}

  it{should belong_to :user}
  it{should belong_to :feed}
end
