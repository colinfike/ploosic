require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  test "site cannot save without name" do
    site = Site.new
    assert_not site.save
  end

  test "site can have many tracks" do
    site = sites(:has_tracks)
    assert_equal(2, site.tracks.count)
  end
end
