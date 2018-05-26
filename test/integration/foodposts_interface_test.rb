require 'test_helper'

class FoodpostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "foodpost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Foodpost.count' do
      post foodposts_path, params: { foodpost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This foodpost really ties the room together"
    assert_difference 'Foodpost.count', 1 do
      post foodposts_path, params: { foodpost: { content: content,
                                                 protein: 30,
                                                 fat: 10,
                                                 carbohydrate: 70 } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_foodpost = @user.foodposts.paginate(page: 1).first
    assert_difference 'Foodpost.count', -1 do
      delete foodpost_path(first_foodpost)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
  
end