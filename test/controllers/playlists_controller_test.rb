require 'test_helper'

class PlaylistsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @playlist = playlists(:valid_playlist)
  end

  test "should get show page" do
    get playlist_url(@playlist)
    assert_response :success
  end

  test "show page should show tracks" do
    get playlist_url(@playlist)

    @playlist.tracks.each do |track|
      assert_select '.track' do
        assert_select '.track__name', track.name
      end
    end
  end
end
