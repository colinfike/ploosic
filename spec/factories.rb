FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "person#{n}" }
  end

  factory :site do
    sequence(:name) { |n| "site#{n}" }
  end

  factory :track do
    site
    sequence(:name) { |n| "track#{n}" }
    sequence(:url) { |n| "https://soundcloud.com/#{n}" }
  end

  factory :playlist do
    user
    trait :has_tracks do

    end
  end
end
