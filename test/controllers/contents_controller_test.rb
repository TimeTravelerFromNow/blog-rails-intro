require "test_helper"

class ContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get contents_create_url
    assert_response :success
  end

  test "should get update" do
    get contents_update_url
    assert_response :success
  end

  test "should get destroy" do
    get contents_destroy_url
    assert_response :success
  end
end
