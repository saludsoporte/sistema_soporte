require "test_helper"

class SolicitudsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get solicituds_index_url
    assert_response :success
  end

  test "should get new" do
    get solicituds_new_url
    assert_response :success
  end

  test "should get edit" do
    get solicituds_edit_url
    assert_response :success
  end

  test "should get show" do
    get solicituds_show_url
    assert_response :success
  end
end
