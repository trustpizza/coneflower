require "test_helper"

class Moderator::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get moderator_comments_index_url
    assert_response :success
  end

  test "should get show" do
    get moderator_comments_show_url
    assert_response :success
  end

  test "should get edit" do
    get moderator_comments_edit_url
    assert_response :success
  end

  test "should get update" do
    get moderator_comments_update_url
    assert_response :success
  end

  test "should get destroy" do
    get moderator_comments_destroy_url
    assert_response :success
  end
end
