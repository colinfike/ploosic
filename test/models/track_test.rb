require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  test "tracks can't save without name" do
    track = Track.new
    assert_not track.save
  end

  test "tracks can't save without site id" do
    track = Track.new
    assert_not track.save
  end

  test "tracks can't save without user id" do
    track = Track.new
    assert_not track.save
  end

  test "tracks can't save without url" do
    track = Track.new
    assert_not track.save
  end

  test 'track must have valid url' do
    track = Track.new
    track.url = 'https://soundcloud.com'
    assert_not track.save
  end

  test 'tracks can belong to site' do
    track = tracks(:valid_track)
    assert_equal sites(:valid_site), track.site
  end

  test 'track can belong to user' do
    track = tracks(:valid_track)
    assert_equal users(:valid_user), track.user
  end

  test 'track can have many playlists' do
    track = tracks(:valid_track)
    assert_equal 3, track.playlists.count
  end
end
