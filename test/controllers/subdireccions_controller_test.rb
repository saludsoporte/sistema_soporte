require "test_helper"

class SubdireccionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subdireccions_new_url
    assert_response :success
  end
end
