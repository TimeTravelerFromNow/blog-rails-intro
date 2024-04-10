require "test_helper"

class ExtLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ext_link = ext_links(:one)
  end

  test "should get index" do
    get ext_links_url
    assert_response :success
  end

  test "should get new" do
    get new_ext_link_url
    assert_response :success
  end

  test "should create ext_link" do
    assert_difference("ExtLink.count") do
      post ext_links_url, params: { ext_link: { fa_class: @ext_link.fa_class, fa_icon: @ext_link.fa_icon, link: @ext_link.link } }
    end

    assert_redirected_to ext_link_url(ExtLink.last)
  end

  test "should show ext_link" do
    get ext_link_url(@ext_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_ext_link_url(@ext_link)
    assert_response :success
  end

  test "should update ext_link" do
    patch ext_link_url(@ext_link), params: { ext_link: { fa_class: @ext_link.fa_class, fa_icon: @ext_link.fa_icon, link: @ext_link.link } }
    assert_redirected_to ext_link_url(@ext_link)
  end

  test "should destroy ext_link" do
    assert_difference("ExtLink.count", -1) do
      delete ext_link_url(@ext_link)
    end

    assert_redirected_to ext_links_url
  end
end
