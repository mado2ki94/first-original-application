FactoryGirl.define do
  factory :user, aliases: [:follower, :followed] do
    id 1
    name "yosuke suita"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "foobar"
    introduction "Nice to meet you"
  end
end
