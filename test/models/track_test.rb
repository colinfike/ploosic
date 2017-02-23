require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  test "tracks can't save without fields" do
    track = Track.new
    assert_not track.save
  end

  test 'tracks can associate with site' do
    track = Track.new
    track.site = sites(:soundcloud)
    assert track.save
  end

  test 'track can associate with user' do
    track = Track.new
    track.user = users(:colin)
    assert track.save
  end

  test 'track must have valid url' do
    track = Track.new
    track.url = '9da7s9dhiasdia'
    assert_not track.save
  end
end
