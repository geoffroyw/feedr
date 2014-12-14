require 'spec_helper'

describe CategoriesController do

  login_user

  describe 'Get new' do
    before(:each) do
      get 'new'
    end
    it 'assign @new_category' do
      expect(assigns(:category))
    end

    it 'renders new' do
      is_expected.to render_template :new
    end
  end

  describe 'Get index' do
    before(:each) do
      get 'index'
    end
    it 'assign @categories' do
      expect(assigns(:categories))
    end

    it 'renders index' do
      is_expected.to render_template :index
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new feed' do
        expect {
          post :create, category: attributes_for(:category)
        }.to change(Category, :count).by(1)
      end

      it 'redirect to category path' do
        post :create, category: attributes_for(:category)
        is_expected.to redirect_to category_path(Category.last)
      end

      it 'assign @new_feed' do
        post :create, category: attributes_for(:category)
        expect(assigns(:new_feed))
      end

      it 'adds the category to user catgories' do
        expect {
          post :create, category: attributes_for(:category)
        }.to change(@current_user.categories, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        post :create, category: attributes_for(:invalid_category)
      end
      it 'does not save the feed' do
        expect {
          post :create, category: attributes_for(:invalid_category)
        }.to_not change{Category.count}
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
          post :create, category: attributes_for(:invalid_category)
        }.to_not change{@current_user.categories.count}
      end
    end
  end

  describe "GET 'edit'" do
    context 'with valid user' do
      before(:each) do
        @category = create(:category, user: @current_user)
        get 'edit', id: @category
      end
      it 'asssign the request category to @category' do
        expect(assigns(:category)).to eq @category

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
        @category = create(:category)
      end

      it 'raises 404' do
        expect{ get 'edit', id: @category}.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end


  describe "DELETE 'destroy'" do
    context 'with valid user and valid parameters' do
      before(:each) do
        @category = create(:category, user: @current_user)
        patch 'destroy', id: @category
      end
      it 'asssign the request category to @category' do
        expect(assigns(:category)).to eq @category

      end

      it 'deletes the category' do
        @category = create(:category, user: @current_user)
        @category.save!
        expect {
            delete :destroy, id: @category
          }.to change(Category, :count).by(-1)
      end

      it 'redirect to categories path' do
        is_expected.to redirect_to categories_path
      end
    end


    context 'with invalid user' do
      before(:each) do
        @category = create(:category)
      end

      it 'raises 404' do
        expect{ patch 'update', id: @category, category: attributes_for(:category, name: 'new name')}.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
