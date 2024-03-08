require "test_helper"

class ContentControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get content_update_url
    assert_response :success
  end

  test "should get destroy" do
    get content_destroy_url
    assert_response :success
  end
end
