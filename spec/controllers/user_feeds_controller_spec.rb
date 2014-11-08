require 'spec_helper'

describe UserFeedsController do
  login_user

  before :each do
    allow(Feedjira::Feed).to receive(:fetch_and_parse).and_return(OpenStruct.new ({:title => 'title', :entries => []}))
  end

  describe "GET 'edit'" do
    context 'with valid user' do
      before(:each) do
        @user_feed = create(:user_feed, user: @current_user)
        get 'edit', id: @user_feed.feed
      end
      it 'asssign the request user_feed to @user_feed' do
        expect(assigns(:user_feed)).to eq @user_feed

      end

      it 'renders edit' do
        is_expected.to render_template :edit
      end

      it 'assign @new_feed' do
        expect(assigns(:new_feed))
      end

    end

    context 'with invalid user' do
      before(:each) do
        @user_feed = create(:user_feed)
      end

      it 'raises 404' do
        expect{ get 'edit', id: @user_feed.feed}.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end


  describe "PATCH 'update'" do
    context 'with valid user and valid parameters' do
      before(:each) do
        @user_feed = create(:user_feed, user: @current_user)
        patch 'update', id: @user_feed.feed, user_feed: attributes_for(:user_feed, name: 'new name')
      end
      it 'asssign the request user_feed to @user_feed' do
        expect(assigns(:user_feed)).to eq @user_feed

      end

      it 'changes @user_feed attributes' do
        @user_feed.reload
        expect(@user_feed.name).to eq 'new name'
      end

      it 'redirect to feed_path' do
        is_expected.to redirect_to @user_feed.feed
      end
    end

    context 'with valid user and invalid parameters' do
      before(:each) do
        @user_feed = create(:user_feed, user: @current_user)
        patch 'update', id: @user_feed.feed, user_feed: attributes_for(:user_feed, name: '')
      end
      it 'asssign the request user_feed to @user_feed' do
        expect(assigns(:user_feed)).to eq @user_feed

      end

      it 'does not changes @user_feed attributes' do
        @user_feed.reload
        expect(@user_feed.name).to_not eq 'new name'
      end

      it 're-render edit screen' do
        is_expected.to render_template :edit
      end

      it 'assigns @errors' do
        expect(assigns(:errors))
      end

      it 'assign @new_feed' do
        expect(assigns(:new_feed))
      end
    end

    context 'with invalid user' do
      before(:each) do
        @user_feed = create(:user_feed)
      end

      it 'raises 404' do
        expect{ patch 'update', id: @user_feed.feed, user_feed: attributes_for(:user_feed, name: 'new name')}.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end



end
