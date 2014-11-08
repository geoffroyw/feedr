# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "mail#{n}@provider.tld"
    end
    password "P@ssword"

    factory :user_with_feeds do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator


      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user|
        create_list(:user_feed, 5, user: user)
      end
    end
  end
end
