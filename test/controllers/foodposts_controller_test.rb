require 'test_helper'

class FoodpostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @foodpost = foodposts(:breakfast)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Foodpost.count' do
      post foodposts_path, params: { foodpost: { content: "breakfast",
                                                 protein: 40,
                                                 fat: 10,
                                                 carbohydrate: 70 } }
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Foodpost.count' do
      delete foodpost_path(@foodpost)
    end
    assert_redirected_to login_url
  end
  
  # editのアクセス制限テスト
  test "should redirect edit when not logged in" do
    get edit_foodpost_path(@foodpost)
    assert_redirected_to login_url
  end
  
  # updateのアクセス制限テスト
  test "should redirect update when not logged in" do
    patch foodpost_path(@foodpost), params: { foodpost: { content: "updated content",
                                                protein: 40,
                                                fat: 10,
                                                carbohydrate: 70 } }
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong foodpost" do
    log_in_as(users(:michael))
    foodpost = foodposts(:food_1)
    assert_no_difference 'Foodpost.count' do
      delete foodpost_path(foodpost)
    end
    assert_redirected_to root_url
  end
  
  
end
