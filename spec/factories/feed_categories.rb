# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed_category do
    name {Faker::Lorem.sentence(1)}
    association :user_feed, factory: :user_feed, strategy: :build
    association :user, factory: :user, strategy: :build
    parent_id 1
    lft 1
    rgt 1
    depth 1
  end
end
