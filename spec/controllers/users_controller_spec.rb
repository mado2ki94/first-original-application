require 'rails_helper'
require 'sessions_helper'

RSpec.describe UsersController, type: :controller do
  describe "#show" do
    before do
      @user = FactoryGirl.create(:user)
    end
    # 正常にレスポンスを返すこと
    it "responds succsessfully" do
      get :show, params: { id: @user.id }
      expect(response).to be_success
    end
    # 200レスポンスを返すこと
    it "returns a 200 response" do
      get :show, params: { id: @user.id }
      expect(response).to have_http_status "200"
    end
  end
  
  describe "#create" do
  end
end
