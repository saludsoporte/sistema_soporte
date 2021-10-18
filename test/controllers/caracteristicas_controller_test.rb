require "test_helper"

class CaracteristicasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get caracteristicas_index_url
    assert_response :success
  end

  test "should get show" do
    get caracteristicas_show_url
    assert_response :success
  end

  test "should get new" do
    get caracteristicas_new_url
    assert_response :success
  end

  test "should get edit" do
    get caracteristicas_edit_url
    assert_response :success
  end
end
