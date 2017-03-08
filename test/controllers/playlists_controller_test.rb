require 'test_helper'

class PlaylistsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @playlist = playlists(:valid_playlist)
  end

  test "should get show page" do
    get playlists_url(@playlist)
    assert_response :success
  end

  test "show page should show tracks" do
    get playlists_url(@playlist)

    assert_select 'track' do
      assert_select 'track__title', @playlist.tracks.first
    end
  end
end
