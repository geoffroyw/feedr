require 'spec_helper'

describe ItemsController do

  before :each do
    allow(Feedjira::Feed).to receive(:fetch_and_parse).and_return(OpenStruct.new ({:title => 'title', :entries => []}))
  end

  login_user


  describe "GET 'show'" do
    before(:each) do
      @feed = create(:feed_with_items)
      @item = @feed.items.first
      get 'show', id: @item, feed_id: @feed
    end
    it 'asssigns the request item to @item' do
      expect(assigns(:item)).to eq @item

    end

    it 'render item_content partial' do
      is_expected.to render_template(:partial => 'items/_item_content')
    end

    it 'assign @new_feed' do
      expect(assigns(:new_feed))
    end

    it 'increase read_count' do
      @item.reload
      expect(@item.read_count).to eq(1)

      get 'show', id: @item, feed_id: @feed
      @item.reload
      expect(@item.read_count).to eq(2)
    end
    it 'add item to user items' do
      expect(@current_user.items).to include(@item)
    end

    it 'does creates duplicate entries in user_item' do
      user_item_count = UserItem.where('item_id' => @item.id).count
      expect(user_item_count ).to eq(1)

      get 'show', id: @item, feed_id: @feed

      user_item_count = UserItem.where('item_id' => @item.id).count
      expect(user_item_count ).to eq(1)

    end
  end

  describe "GET 'read'" do
    before(:each) do
      @feed = create(:feed_with_items)
      @item = @feed.items.first
      get 'read', id: @item, feed_id: @feed, format: :json
    end
    it 'responds with json success' do
      @expected = {:success => true}.to_json
      expect(response.body).to eq @expected
    end

    it 'assign @new_feed' do
      expect(assigns(:new_feed))
    end

    it 'increase read_count' do
      @item.reload
      expect(@item.read_count).to eq(1)

      get 'show', id: @item, feed_id: @feed
      @item.reload
      expect(@item.read_count).to eq(2)
    end

    it 'add item to user items' do
      expect(@current_user.items).to include(@item)
    end
  end

  describe "GET 'view'" do
    before(:each) do
      @feed = create(:feed_with_items)
      @item = @feed.items.first
      get 'view', id: @item, feed_id: @feed
    end
    it 'redirect to item url' do
      is_expected.to redirect_to @item.url
    end

    it 'increase view_count' do
      @item.reload
      expect(@item.view_count).to eq(1)

      get 'view', id: @item, feed_id: @feed
      @item.reload
      expect(@item.view_count).to eq(2)
    end

    it 'add item to user items' do
      expect(@current_user.items).to include(@item)
    end
  end

end
