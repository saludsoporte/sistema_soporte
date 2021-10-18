require "test_helper"

class RelacionComponentesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relacion_componentes_index_url
    assert_response :success
  end

  test "should get show" do
    get relacion_componentes_show_url
    assert_response :success
  end

  test "should get new" do
    get relacion_componentes_new_url
    assert_response :success
  end

  test "should get edit" do
    get relacion_componentes_edit_url
    assert_response :success
  end
end
