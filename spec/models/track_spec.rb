require 'rails_helper'

RSpec.describe Track, 'track attribute tests' do
  it 'cannot save without a name' do
    track = build(:track, name: nil)
    result = track.save
    expect(result).to be false
  end

  it 'cannot save without a site' do
    track = build(:track, site: nil)
    result = track.save
    expect(result).to be false
  end

  it 'cannot save without a url' do
    track = build(:track, url: nil)
    result = track.save
    expect(result).to be false
  end

  it 'cannot save with an invalid url' do
    track = build(:track, url: 'https://mysterysite.com')
    result = track.save
    expect(result).to be false
  end

  it 'can belong to a site' do
    track = build(:track)
    expect(track.site).not_to be_nil
  end

  it 'can have many playlists' do
    track = build(:track)
    # Not sure if it's best for this to be in trait or well defined here
    3.times{ create(:track_playlist, track: track) }
    expect(track.playlists.count).to eq(3)
  end
end
