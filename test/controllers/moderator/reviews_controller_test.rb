require "test_helper"

class Moderator::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get moderator_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get moderator_reviews_show_url
    assert_response :success
  end

  test "should get edit" do
    get moderator_reviews_edit_url
    assert_response :success
  end

  test "should get update" do
    get moderator_reviews_update_url
    assert_response :success
  end

  test "should get destroy" do
    get moderator_reviews_destroy_url
    assert_response :success
  end
end
