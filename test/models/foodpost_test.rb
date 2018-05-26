require 'test_helper'

class FoodpostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @foodpost = @user.foodposts.build(content: "sushi",
                                      protein: 30,
                                      fat: 15,
                                      carbohydrate: 90)
  end
  
  test "should be valid" do
    assert @foodpost.valid?
  end
  
  test "user id should be present" do
    @foodpost.user_id = nil
    assert_not @foodpost.valid?
  end
  
  test "protein should be present" do
    @foodpost.protein = nil
    assert_not @foodpost.valid?
  end
  
  test "fat id should be present" do
    @foodpost.fat = nil
    assert_not @foodpost.valid?
  end
  
  test "carbohydrate id should be present" do
    @foodpost.carbohydrate = nil
    assert_not @foodpost.valid?
  end
  
  test "content should be at most 400 characters" do
    @foodpost.content = "a" * 401
    assert_not @foodpost.valid?
  end
  
  test "order should be most recent first" do
    assert_equal foodposts(:snack), Foodpost.first
  end
end
