require 'spec_helper'

describe UserItem, :type => :model do
  it{should validate_presence_of :user}
  it{should validate_presence_of :item}
  it{should validate_presence_of :feed}

  it{should belong_to :user}
  it{should belong_to :item}
  it{should belong_to :feed}
end
