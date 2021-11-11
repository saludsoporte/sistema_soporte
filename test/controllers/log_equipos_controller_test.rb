require "test_helper"

class LogEquiposControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get log_equipos_index_url
    assert_response :success
  end

  test "should get show" do
    get log_equipos_show_url
    assert_response :success
  end
end
