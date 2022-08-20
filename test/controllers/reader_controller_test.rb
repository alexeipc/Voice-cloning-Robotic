require "test_helper"

class ReaderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reader_index_url
    assert_response :success
  end
end
