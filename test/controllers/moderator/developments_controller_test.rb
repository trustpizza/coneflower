require "test_helper"

class Moderator::DevelopmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get moderator_developments_index_url
    assert_response :success
  end

  test "should get show" do
    get moderator_developments_show_url
    assert_response :success
  end

  test "should get edit" do
    get moderator_developments_edit_url
    assert_response :success
  end

  test "should get update" do
    get moderator_developments_update_url
    assert_response :success
  end

  test "should get destroy" do
    get moderator_developments_destroy_url
    assert_response :success
  end
end
