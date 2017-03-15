require 'test_helper'
# CONVERTED
class UserTest < ActiveSupport::TestCase
  test "user can't save without username" do
    user = User.new
    assert_not user.save
  end
end
