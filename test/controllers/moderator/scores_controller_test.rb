require "test_helper"

class Moderator::ScoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get moderator_scores_index_url
    assert_response :success
  end

  test "should get show" do
    get moderator_scores_show_url
    assert_response :success
  end

  test "should get edit" do
    get moderator_scores_edit_url
    assert_response :success
  end

  test "should get update" do
    get moderator_scores_update_url
    assert_response :success
  end

  test "should get destroy" do
    get moderator_scores_destroy_url
    assert_response :success
  end
end
