require 'rails_helper'

RSpec.describe Foodpost, type: :model do
  # 有効なファクトリを持つこと
  it "has valid factory" do
    expect(FactoryGirl.build(:foodpost)).to be_valid
  end
  # ユーザーIDがなければ無効であること
  it "is invalid without user id" do
    foodpost = FactoryGirl.build(:foodpost, user_id: nil)
    foodpost.valid?
    expect(foodpost.errors[:user_id]).to include("を入力してください")
  end
  # タンパク質がなければ無効であること
  it "is invalid without protein" do
    foodpost = FactoryGirl.build(:foodpost, protein: nil)
    foodpost.valid?
    expect(foodpost.errors[:protein]).to include("を入力してください")
  end
  # 脂質がなければ無効であること
  it "is invalid without fat" do
    foodpost = FactoryGirl.build(:foodpost, fat: nil)
    foodpost.valid?
    expect(foodpost.errors[:fat]).to include("を入力してください")
  end
  # 炭水化物がなければ無効であること
  it "is invalid without carbohydrate" do
    foodpost = FactoryGirl.build(:foodpost, carbohydrate: nil)
    foodpost.valid?
    expect(foodpost.errors[:carbohydrate]).to include("を入力してください")
  end
  # コメントは400文字以下であること
  describe "content is at most 400 characters" do
    # 400文字の場合
    context "with 400 characters" do
      # 有効である
      it "is valid" do
        expect(FactoryGirl.build(:foodpost, content: "a" * 400)).to be_valid
      end
    end
    # 401文字の場合
    context "with 401 characters" do
      # 無効である
      it "is invalid" do
        foodpost = FactoryGirl.build(:foodpost, content: "a" * 401)
        foodpost.valid?
        expect(foodpost.errors[:content]).to include("は400文字以内で入力してください")
      end
    end
  end
end
