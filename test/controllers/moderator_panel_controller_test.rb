require "test_helper"

class ModeratorPanelControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get moderator_panel_index_url
    assert_response :success
  end
end
