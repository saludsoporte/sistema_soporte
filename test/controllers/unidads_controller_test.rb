require "test_helper"

class UnidadsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get unidads_new_url
    assert_response :success
  end
end
