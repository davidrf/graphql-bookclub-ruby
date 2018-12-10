FactoryBot.define do
  factory :repository do
    sequence(:name) { |n| "popular-front-end-framework-#{n}" }
    user

    trait :private do
      private { true }
    end

    trait :with_collaborators do
      transient do
        with_collaborators { create_list(:user, 2) }
      end

      after(:create) do |repository, evaluator|
        evaluator.with_collaborators.each do |collaborator|
          create(:collaboration, repository: repository, user: collaborator)
        end
      end
    end

    factory :private_repository, traits: [:private]
    factory :repository_with_collaborators, traits: [:with_collaborators]
  end
end