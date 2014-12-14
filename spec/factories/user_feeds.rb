# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_feed do
    name {Faker::Lorem.sentence(1)}
    association :feed, factory: :feed, strategy: :build
    association :user, factory: :user, strategy: :build
    #association :category, factory: :category, strategy: :build

  end
end
