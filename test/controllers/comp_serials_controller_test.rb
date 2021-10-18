require "test_helper"

class CompSerialsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get comp_serials_new_url
    assert_response :success
  end
end
