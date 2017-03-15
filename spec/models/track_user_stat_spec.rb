require 'rails_helper'

RSpec.describe TrackUserStat, 'track_playlist attribute tests' do
  it 'cannot save without a user' do
    track_user_stat = build(:track_user_stat, user: nil)
    result = track_user_stat.save
    expect(result).to be false
  end

  it 'cannot save without a track' do
    track_user_stat = build(:track_user_stat, track: nil)
    result = track_user_stat.save
    expect(result).to be false
  end
end
