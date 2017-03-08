require 'test_helper'

class PlaylistsHelperTest < ActionView::TestCase
  test "should return track block" do
      playlist = playlists(:valid_playlist)

      assert_dom_equal %{<div class="track"><span class="track__name">#{playlist.tracks.first.name}</span></div>},
        render_track(playlist.tracks.first)
    end
end
