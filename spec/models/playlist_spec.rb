require 'rails_helper'

RSpec.describe User, 'playlist attribute testing' do
  it "playlist can't save without a user" do
    playlist = build(:playlist, user: nil)
    result = playlist.save
    expect(result).to be false
  end

  it "playlist can have multiple tracks" do
    playlist = build(:playlist, :has_tracks)
    expect(playlist.tracks.count).to eq(3)
  end
end