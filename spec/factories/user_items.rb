# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_item do
    association :user, factory: :user, strategy: :build
    association :item, factory: :item, strategy: :build
  end
end
