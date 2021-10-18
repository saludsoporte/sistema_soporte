require "test_helper"

class PerfilControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get perfil_index_url
    assert_response :success
  end

  test "should get new" do
    get perfil_new_url
    assert_response :success
  end

  test "should get edit" do
    get perfil_edit_url
    assert_response :success
  end
end
