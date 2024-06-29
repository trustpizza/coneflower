require "test_helper"

class Moderator::SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get Index" do
    get moderator_search_Index_url
    assert_response :success
  end
end
