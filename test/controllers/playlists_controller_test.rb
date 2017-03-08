require 'test_helper'

class PlaylistsControllerTest < ActionDispatch::IntegrationTest
  test "should get show page" do
    get playlists_url
    assert_response :success
  end
end
