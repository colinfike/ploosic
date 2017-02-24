require 'test_helper'

class TrackPlaylistTest < ActiveSupport::TestCase

  test "track_playlist can't save without track" do
    track_playlist = TrackPlaylist.new(playlist: playlists(:valid_playlist))
    assert_not track_playlist.save
  end
  test "track_playlist can't save without playlist" do
    track_playlist = TrackPlaylist.new(track: tracks(:valid_track))
    assert_not track_playlist.save
  end

  test "track_playlist can belong to track" do
    track_playlist = track_playlists(:valid_track_playlist)
    assert_equal tracks(:valid_track), track_playlist.track
  end

  test "track_playlist can belong to playlist" do
    track_playlist = track_playlists(:valid_track_playlist)
    assert_equal playlists(:valid_playlist), track_playlist.playlist
  end
end
