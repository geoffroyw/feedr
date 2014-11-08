# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    feed
    url { Faker::Internet.url }
    description {Faker::Lorem.paragraph(2)}
    title {Faker::Lorem.sentence(3)}
    published_at {Faker::Date.between(2.days.ago, Date.today)}
  end
end
