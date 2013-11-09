# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed_item do
    feed_id 1
    url "MyString"
    description "MyString"
    title "MyString"
    published_at "2013-11-09 18:29:23"
  end
end
