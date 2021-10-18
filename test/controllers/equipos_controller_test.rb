require "test_helper"

class EquiposControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get equipos_index_url
    assert_response :success
  end

  test "should get show" do
    get equipos_show_url
    assert_response :success
  end

  test "should get edit" do
    get equipos_edit_url
    assert_response :success
  end
end
