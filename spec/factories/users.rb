FactoryBot.define do
  factory :user do
    bio { Faker::Lorem.paragraph }
    sequence(:first_name) { |n| "D#{n}" }
    sequence(:last_name) { |n| "-Rod#{n}" }
    picture_url { "http://loremflickr.com/300/300" }
    sequence(:username) { |n| "drod#{n}" }
  end
end
