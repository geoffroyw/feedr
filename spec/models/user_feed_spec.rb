require 'spec_helper'

describe UserFeed do
  it{should validate_presence_of :user}
  it{should validate_presence_of :feed}
  it{should validate_presence_of :name}

  it{should belong_to :user}
  it{should belong_to :feed}

  it { should callback(:set_default_name).before(:validation)}

  it{should have_many :feed_categories}
end
