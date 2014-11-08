require 'spec_helper'

describe FeedsController do

  login_user

  before :each do
    allow(Feedjira::Feed).to receive(:fetch_and_parse).and_return(OpenStruct.new ({:title => 'title', :entries => []}))
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

    it 'assign @new_feed' do
      expect(assigns(:new_feed))
    end

  end

  describe 'Get new' do
    before(:each) do
      get 'new'
    end
    it 'assign @new_feed' do
      expect(assigns(:new_feed))
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new feed' do
        expect {
          post :create, feed: attributes_for(:feed)
        }.to change(Feed, :count).by(1)
      end

      it 'redirect to home' do
        post :create, feed: attributes_for(:feed)
        is_expected.to redirect_to :homes_show
      end

      it 'assign @new_feed' do
        post :create, feed: attributes_for(:feed)
        expect(assigns(:new_feed))
      end

      it 'adds the feed to user feeds' do
        expect {
          post :create, feed: attributes_for(:feed)
        }.to change(@current_user.user_feeds, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        post :create, feed: attributes_for(:invalid_feed)
      end
      it 'does not save the feed' do
        expect {
          post :create, feed: attributes_for(:invalid_feed)
        }.to_not change{Feed.count}
      end

      it 'assigns the @errors' do
        expect(assigns(:errors))
      end

      it 're-renders the new method' do
        is_expected.to render_template :new
      end

      it 'assign @new_feed' do
        expect(assigns(:new_feed))
      end

      it 'does not add the feed to user feeds' do
        expect {
          post :create, feed: attributes_for(:invalid_feed)
        }.to_not change{@current_user.user_feeds.count}
      end
    end
  end

end
