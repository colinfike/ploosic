require 'test_helper'
# CONVERTED
class SiteTest < ActiveSupport::TestCase
  test "site cannot save without name" do
    site = Site.new
    assert_not site.save
  end

  test "site can have many tracks" do
    site = sites(:soundcloud)
    assert_equal(3, site.tracks.count)
  end
end
