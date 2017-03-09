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
    assert_dom_equal %{<div class="none" data-playlist="[#{@playlist.tracks.first.to_json}]"></div>}, render_data_div(@playlist.tracks)
  end
end
