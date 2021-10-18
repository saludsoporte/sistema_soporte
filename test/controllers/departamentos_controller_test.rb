require "test_helper"

class DepartamentosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get departamentos_new_url
    assert_response :success
  end
end
