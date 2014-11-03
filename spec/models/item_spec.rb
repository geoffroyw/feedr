require 'spec_helper'


describe Item do
  it{should validate_presence_of :url}
  it{should validate_presence_of :title}
  it{should belong_to :feed}
  it{should have_many :user_items}
  it{should validate_numericality_of(:view_count).only_integer.is_greater_than_or_equal_to(0)}
  it{should validate_numericality_of(:read_count).only_integer.is_greater_than_or_equal_to(0)}

  it { should callback(:set_count_to_zero).before(:validation)}
end
