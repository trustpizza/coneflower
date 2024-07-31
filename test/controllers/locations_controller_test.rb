require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get set" do
    get locations_set_url
    assert_response :success
  end
end
