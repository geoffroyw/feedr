require 'spec_helper'

describe HomesController do
  login_user


  describe "GET 'show'" do
    before(:each) do
      get 'show'
    end


    describe 'returns http success' do
      it{should respond_with :success}
    end

    describe 'assign @new_feed' do
      it{assigns(:new_feed)}
    end
  end

end
