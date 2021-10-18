require "test_helper"

class ComponentesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get componentes_index_url
    assert_response :success
  end

  test "should get show" do
    get componentes_show_url
    assert_response :success
  end

  test "should get new" do
    get componentes_new_url
    assert_response :success
  end

  test "should get edit" do
    get componentes_edit_url
    assert_response :success
  end
end
