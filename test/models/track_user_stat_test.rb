require 'test_helper'

class TrackUserStatTest < ActiveSupport::TestCase
  test "track_user_stat can't save without user" do
    track_user_stat = TrackUserStat.new(track: tracks(:valid_track))
    assert_not track_user_stat.save
  end
  test "track_user_stat can't save without track" do
    track_user_stat = TrackUserStat.new(user: users(:valid_user))
    assert_not track_user_stat.save
  end
end
