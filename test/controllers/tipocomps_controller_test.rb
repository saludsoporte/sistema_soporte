require "test_helper"

class TipocompsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tipocomps_index_url
    assert_response :success
  end

  test "should get show" do
    get tipocomps_show_url
    assert_response :success
  end

  test "should get new" do
    get tipocomps_new_url
    assert_response :success
  end

  test "should get edit" do
    get tipocomps_edit_url
    assert_response :success
  end
end
