require "test_helper"

class AsignacionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get asignacions_index_url
    assert_response :success
  end

  test "should get show" do
    get asignacions_show_url
    assert_response :success
  end

  test "should get new" do
    get asignacions_new_url
    assert_response :success
  end
end
