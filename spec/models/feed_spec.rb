require 'spec_helper'



describe Feed do
  before :each do
    allow(Feedjira::Feed).to receive(:fetch_and_parse).and_return(OpenStruct.new ({:title => 'title'}))
  end

  it{should validate_presence_of :url}
  it{should validate_uniqueness_of(:url).case_insensitive}

  it{should have_many(:items)}
  it{should have_many(:user_feeds)}
  it{should have_many(:users).through :user_feeds }

  it { should callback(:fetch_name).before(:save)}
end
