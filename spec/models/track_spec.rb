require 'rails_helper'

RSpec.describe Track, "validations" do
  it { is_expected.to validate_presence_of(:site) }
  it { is_expected.to validate_presence_of(:url) }
  it {should_not allow_value('https://mysterysite.com').for(:url)}
  it do
    should allow_values('https://youtu.be/44bigiDX6lI',
     'https://soundcloud.com/scottishfoldlp/blinded-by-light-final-fantasy').
      for(:url)
  end
end

RSpec.describe Track, ".create" do
  it 'detects and sets attributes based on url' do
    soundcloud = create(:site, name: 'SoundCloud')
    track = Track.new(url: 'https://soundcloud.com/moeshop/love-taste')
    track.save
    expect(track.site.name).to eq('SoundCloud')
    expect(track.name).to eq('Love Taste (w/ Jamie Paige & Shiki)')
    expect(track.artist_name).to eq('Moe Shop')
  end
end

RSpec.describe Track, ".add_to_playlist" do
  it "adds track to playlist" do
    track_url = "https://soundcloud.com/moeshop/love-taste"
    playlist = create(:playlist)

    result = Track.add_to_playlist track_url, playlist.id

    expect(playlist.tracks.count).to eq(1)
    expect(result).to be_truthy
  end

  it "returns false if url is invalid" do
    track_url = "coolsounds.co?cool_track=123"
    playlist = create(:playlist)

    result = Track.add_to_playlist track_url, playlist.id

    expect(playlist.tracks.count).to eq(0)
    expect(result).to be false
  end

  # May be over kill to check ALL params
  it "returns false if playlist is invalid" do
    track_url = "https://soundcloud.com/moeshop/love-taste"
    playlist = nil

    result = Track.add_to_playlist track_url, playlist

    expect(result).to be false
  end
end

# FIXME: (POTENTIALLY) This is just saving and testing this works via callback.
# I'd rather call it directly but since it's private I can't. I may be able to
# do this better with stubbing or something.
RSpec.describe Track, "#fetch_soundcloud_info" do
  it 'sets artist_name and track with valid url' do
    track_url = 'https://soundcloud.com/moeshop/love-taste'
    track = Track.new(url: track_url)

    track.save

    expect(track.artist_name).to eq('Moe Shop')
    expect(track.name).to eq('Love Taste (w/ Jamie Paige & Shiki)')
  end

  it 'sets artist_name and track to unknown with invalid url' do
    track_url = 'https://soundcloud.com/moeshop/oasndona-taste'
    track = Track.new(url: track_url)

    track.save

    expect(track.artist_name).to eq('Unknown')
    expect(track.name).to eq('Unknown')
  end
end

RSpec.describe Track, "#fetch_youtube_info" do
  it 'sets artist_name and track with valid url' do
    track_url = 'https://youtu.be/nY7GnAq6Znw'
    track = Track.new(url: track_url)

    track.save

    expect(track.artist_name).to eq('Jon Gomm')
    expect(track.name).to eq('Jon Gomm - Passionflower')
  end

  it 'sets artist_name and track to unknown with invalid url' do
    track_url = 'https://youtu.be/nY7GnAq6asdasdZnw'
    track = Track.new(url: track_url)

    track.save

    expect(track.artist_name).to eq('Unknown')
    expect(track.name).to eq('Unknown')
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
