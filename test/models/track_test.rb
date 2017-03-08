require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  test "tracks can't save without name" do
    track = Track.new(site: sites(:soundcloud), user: users(:valid_user), url: 'https://soundcloud.com')
    assert_not track.save
  end

  test "tracks can't save without site id" do
    track = Track.new(user: users(:valid_user), url: 'https://soundcloud.com', name: 'Track 1')
    assert_not track.save
  end

  test "tracks can't save without user id" do
    track = Track.new(site: sites(:soundcloud), url: 'https://soundcloud.com', name: 'Track 1')
    assert_not track.save
  end

  test "tracks can't save without url" do
    track = Track.new(site: sites(:soundcloud), user: users(:valid_user), name: 'Track 1')
    assert_not track.save
  end

  test 'track must have valid url' do
    track = Track.new(site: sites(:soundcloud), user: users(:valid_user), url: 'https://mysterysite.com', name: 'Track 1')
    assert_not track.save
  end

  test 'tracks can belong to site' do
    track = tracks(:valid_track)
    assert_equal sites(:soundcloud), track.site
  end

  test 'track can belong to user' do
    track = tracks(:valid_track)
    assert_equal users(:valid_user), track.user
  end

  test 'track can have many playlists' do
    track = tracks(:valid_track)
    assert_equal 1, track.playlists.count
  end
end
