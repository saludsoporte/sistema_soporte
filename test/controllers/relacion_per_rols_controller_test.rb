require "test_helper"

class RelacionPerRolsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relacion_per_rols_index_url
    assert_response :success
  end

  test "should get edit" do
    get relacion_per_rols_edit_url
    assert_response :success
  end

  test "should get new" do
    get relacion_per_rols_new_url
    assert_response :success
  end

  test "should get show" do
    get relacion_per_rols_show_url
    assert_response :success
  end
end
