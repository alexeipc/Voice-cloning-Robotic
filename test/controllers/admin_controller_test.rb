require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get admin_login_url
    assert_response :success
  end

  test "should get submit" do
    get admin_submit_url
    assert_response :success
  end
end
