require "test_helper"

class AreasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get areas_new_url
    assert_response :success
  end
end
