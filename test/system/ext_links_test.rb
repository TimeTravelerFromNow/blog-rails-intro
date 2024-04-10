require "application_system_test_case"

class ExtLinksTest < ApplicationSystemTestCase
  setup do
    @ext_link = ext_links(:one)
  end

  test "visiting the index" do
    visit ext_links_url
    assert_selector "h1", text: "Ext links"
  end

  test "should create ext link" do
    visit ext_links_url
    click_on "New ext link"

    fill_in "Fa class", with: @ext_link.fa_class
    fill_in "Fa icon", with: @ext_link.fa_icon
    fill_in "Link", with: @ext_link.link
    click_on "Create Ext link"

    assert_text "Ext link was successfully created"
    click_on "Back"
  end

  test "should update Ext link" do
    visit ext_link_url(@ext_link)
    click_on "Edit this ext link", match: :first

    fill_in "Fa class", with: @ext_link.fa_class
    fill_in "Fa icon", with: @ext_link.fa_icon
    fill_in "Link", with: @ext_link.link
    click_on "Update Ext link"

    assert_text "Ext link was successfully updated"
    click_on "Back"
  end

  test "should destroy Ext link" do
    visit ext_link_url(@ext_link)
    click_on "Destroy this ext link", match: :first

    assert_text "Ext link was successfully destroyed"
  end
end
