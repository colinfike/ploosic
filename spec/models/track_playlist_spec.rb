require 'rails_helper'

RSpec.describe TrackPlaylist, 'track_playlist attribute tests' do
  it 'cannot save without a track' do
    track_playlist = build(:track_playlist, track: nil)
    result = track_playlist.save
    expect(result).to be false
  end

  it 'cannot save without a playlist' do
    track_playlist = build(:track_playlist, playlist: nil)
    result = track_playlist.save
    expect(result).to be false
  end

  it 'can belong to track' do
    track_playlist = build(:track_playlist)
    expect(track_playlist.track).not_to be_nil
  end

  it 'can belong to playlist' do
    track_playlist = build(:track_playlist)
    expect(track_playlist.playlist).not_to be_nil
  end
end
