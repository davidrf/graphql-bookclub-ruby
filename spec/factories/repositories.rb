FactoryBot.define do
  factory :repository do
    sequence(:name) { |n| "popular-front-end-framework-#{n}" }
    user

    trait :private do
      private { true }
    end

    factory :private_repository, traits: [:private]
  end
end
