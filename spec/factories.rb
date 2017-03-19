# I think this can be touched up but it's ok for now
FactoryGirl.define do
  factory :track_user_stat do
    track
    user
  end

  factory :user do
    # Need to update this since every user automatically gets a playlist
    trait :has_playlist do
      after(:build) do |user|
        create(:playlist, :has_tracks, user: user)
      end
    end
  end

  factory :site do
    sequence(:name) { |n| "site#{n}" }

    trait :has_tracks do
      after(:build) do |site|
        3.times do
          create(:track, site: site)
        end
      end
    end
  end

  factory :track do
    site
    sequence(:name) { |n| "track#{n}" }
    sequence(:url) { |n| "https://soundcloud.com/#{n}" }
  end

  factory :playlist do
    user

    trait :has_tracks do
      after(:build) do |playlist|
        3.times do
         track = create(:track)
         create(:track_playlist, track: track, playlist: playlist)
       end
      end
    end
  end

  factory :track_playlist do
    track
    playlist
  end
end
