require "test_helper"

class Moderator::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get moderator_users_index_url
    assert_response :success
  end

  test "should get edit" do
    get moderator_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get moderator_users_update_url
    assert_response :success
  end
end
