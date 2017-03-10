require 'test_helper'

class PlaylistsHelperTest < ActionView::TestCase
  setup do
    @playlist = playlists(:valid_playlist)
  end

  test "should return track block" do
    assert_dom_equal %{<div class="track"><span class="track__name">#{@playlist.tracks.first.name}</span></div>},
      render_track(@playlist.tracks.first)
  end

  test "should return hidden data div" do
    assert_dom_equal %{<div id="playlist-data" class="none" data-playlist="[#{@playlist.tracks.first.to_json},#{@playlist.tracks[1].to_json},#{@playlist.tracks[2].to_json}]"></div>},
      CGI.unescapeHTML(render_data_div(@playlist.tracks))
  end
end
