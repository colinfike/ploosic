require 'test_helper'
# CONVERTED
class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "header should exist" do
    get root_url
    assert_select '.header'
  end
end
