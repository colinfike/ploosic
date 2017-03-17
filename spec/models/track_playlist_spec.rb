require 'rails_helper'

RSpec.describe TrackPlaylist, "validations" do
  it { is_expected.to validate_presence_of(:playlist) }
  it { is_expected.to validate_presence_of(:track) }
end

RSpec.describe TrackPlaylist, 'obsolete association tests' do
  it 'can belong to track' do
    track_playlist = build(:track_playlist)
    expect(track_playlist.track).not_to be_nil
  end

  it 'can belong to playlist' do
    track_playlist = build(:track_playlist)
    expect(track_playlist.playlist).not_to be_nil
  end
end
