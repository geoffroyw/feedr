# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed do
    url { Faker::Internet.url }
    name {Faker::Lorem.sentence(1)}

    factory :feed_with_items do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator


      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |feed|
        create_list(:item, 5, feed: feed)
      end
    end
  end

end
