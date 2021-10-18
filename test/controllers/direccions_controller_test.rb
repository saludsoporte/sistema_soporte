require "test_helper"

class DireccionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get direccions_new_url
    assert_response :success
  end
end
