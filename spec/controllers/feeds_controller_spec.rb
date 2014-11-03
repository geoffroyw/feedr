require 'spec_helper'

describe FeedsController do

  login_user

  before :each do
    allow(Feedjira::Feed).to receive(:fetch_and_parse).and_return(OpenStruct.new ({:title => 'title'}))
  end


  describe "GET 'show'" do
    before(:each) do
      @feed_with_item = create(:feed_with_items)
      get 'show', id: @feed_with_item
    end
    it 'asssign the request items to @items' do
      expect(assigns(:items)).to eq @feed_with_item.items

    end

    it 'respond with HTTP success' do
       is_expected.to respond_with :success
    end

  end

end
