require "test_helper"

class RolsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rols_index_url
    assert_response :success
  end

  test "should get show" do
    get rols_show_url
    assert_response :success
  end

  test "should get edit" do
    get rols_edit_url
    assert_response :success
  end
end
