require 'rails_helper'

RSpec.describe ItemController, :type => :controller do

  login_user

  describe "Post 'read'" do
    before(:each) do
      post 'read'
    end
    describe 'returns http success' do
      it{should respond_with :success}
    end
  end

end
