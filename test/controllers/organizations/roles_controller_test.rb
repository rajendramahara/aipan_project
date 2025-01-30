require "test_helper"

class Organizations::RolesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organizations_roles_index_url
    assert_response :success
  end

  test "should get show" do
    get organizations_roles_show_url
    assert_response :success
  end

  test "should get edit" do
    get organizations_roles_edit_url
    assert_response :success
  end

  test "should get new" do
    get organizations_roles_new_url
    assert_response :success
  end
end
