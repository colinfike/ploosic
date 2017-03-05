require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  test "playlist can have many tracks" do
    playlist = playlists(:valid_playlist)
    assert_equal 3, playlist.tracks.count
  end

  test "playlist can't save without user" do
    playlist = Playlist.new()
    assert_not playlist.save
  end
end
