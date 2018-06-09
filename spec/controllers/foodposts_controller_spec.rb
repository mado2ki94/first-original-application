require 'rails_helper'

RSpec.describe FoodpostsController, type: :controller do
  describe "#index" do
    # 正常にレスポンスを返すこと
    it "responds succsessfully" do
      get :index
      expect(response).to be_success
    end
    # 200レスポンスを返すこと
    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end
end
