require "test_helper"

class RelacionCaracteristicasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relacion_caracteristicas_index_url
    assert_response :success
  end

  test "should get show" do
    get relacion_caracteristicas_show_url
    assert_response :success
  end

  test "should get edit" do
    get relacion_caracteristicas_edit_url
    assert_response :success
  end

  test "should get new" do
    get relacion_caracteristicas_new_url
    assert_response :success
  end
end
