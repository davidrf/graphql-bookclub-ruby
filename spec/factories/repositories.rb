FactoryBot.define do
  factory :repository do
    sequence(:name) { |n| "popular-front-end-framework-#{n}" }
    user
  end
end
