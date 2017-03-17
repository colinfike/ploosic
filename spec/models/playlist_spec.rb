require 'rails_helper'
RSpec.describe Playlist, "validations" do
  it { is_expected.to validate_presence_of(:user) }
end

RSpec.describe User, 'obsolete association tests' do
  it "playlist can have multiple tracks" do
    playlist = build(:playlist, :has_tracks)
    expect(playlist.tracks.count).to eq(3)
  end
end
