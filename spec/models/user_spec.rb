require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    # 有効なファクトリを持つこと
    it "has a valid factory" do
        expect(FactoryGirl.build(:user)).to be_valid
    end
    # 名前がなければ無効であること
    it "is invalid without name" do
        user = FactoryGirl.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
    end
    # 名前は50文字以下であること
    describe "is is at most 50 characters" do
        # 49文字の場合
        context "with 50 characters" do
            # 有効である
            it "is valid" do
                expect(FactoryGirl.build(:user, name: "a" * 50)).to be_valid
            end
        end
        
        # 50文字の場合
        context "with 51 characters" do
            # 無効である
            it "is invalid" do
                user = FactoryGirl.build(:user, name: "a" * 51)
                user.valid?
                expect(user.errors[:name]).to include("は50文字以内で入力してください")
            end
        end
    end
    # メールアドレスがなければ無効であること
    it "is invalid without email" do
        user = FactoryGirl.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
    end
    # メールアドレスは255文字以下であること
    describe "email is at most 255 characters" do
        # 255文字の場合
        context "with 255 characters" do
            # 有効である
            it "is valid" do
                expect(FactoryGirl.build(:user, email: "#{"a" * 243}@example.com")).to be_valid
            end
        end
        # 256文字の場合
        context "with 256 characters" do
            # 無効である
            it "is invalid" do
                user = FactoryGirl.build(:user, email: "#{"a" * 244}@example.com")
                user.valid?
                expect(user.errors[:email]).to include("は255文字以内で入力してください")
            end
        end
    end
    # 重複したメールアドレスは無効であること
    it "is invalid with a duplicate email" do
        FactoryGirl.create(:user, email: "test@example.com")
        user = FactoryGirl.build(:user, email: "test@example.com")
        user.valid?
        expect(user.errors[:email]).to include("はすでに存在します")
    end
    # パスワードがなければ無効であること
    it "is invalid without password" do
        user = FactoryGirl.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
    end
    # パスワードは6文字以上であること
    describe "password is at least 6 characters" do
        # 5文字の場合
        context "with 5 characters" do
            # 無効である
            it "is invalid" do
                user = FactoryGirl.build(:user, password: "aaaaa")
                user.valid?
                expect(user.errors[:password]).to include("は6文字以上で入力してください")
            end
        end
        
        # 6文字の場合
        context "with 6 characters" do
            # 有効である
            it "is valid" do
                expect(FactoryGirl.build(:user, password: "aaaaaa")).to be_valid
            end
        end
    end
  end
end
