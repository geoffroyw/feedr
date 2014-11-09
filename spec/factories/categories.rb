# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    name {Faker::Lorem.sentence(1)}
    association :user, factory: :user, strategy: :build
    factory :invalid_category, parent: :category do |f|
      f.name nil
    end
  end
end
