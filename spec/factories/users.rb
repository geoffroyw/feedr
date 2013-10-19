# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "mail#{n}@provider.tld"
    end
    password "P@ssword"
  end
end
