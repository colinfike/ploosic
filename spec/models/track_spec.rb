require 'rails_helper'

RSpec.describe Track, "validations" do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:site) }
  it { is_expected.to validate_presence_of(:url) }
  it {should_not allow_value('https://mysterysite.com').for(:url)}
  it do
    should allow_values('https://youtu.be/44bigiDX6lI',
     'https://soundcloud.com/scottishfoldlp/blinded-by-light-final-fantasy').
      for(:url)
  end
end

RSpec.describe Track, 'obsolete association tests' do
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
