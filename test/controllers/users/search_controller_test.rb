require "test_helper"

class Users::SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_search_index_url
    assert_response :success
  end
end
