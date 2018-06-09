FactoryGirl.define do
  factory :foodpost do
    # user
    user_id 1
    content "checken 300g and rice 200g"
    protein 65
    fat 5
    carbohydrate 80
    picture nil
    association :user
  end
end
