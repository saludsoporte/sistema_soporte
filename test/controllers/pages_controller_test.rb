require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get qr_code_generator" do
    get pages_qr_code_generator_url
    assert_response :success
  end
end
