require "test_helper"

class ReportesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reportes_index_url
    assert_response :success
  end

  test "should get new" do
    get reportes_new_url
    assert_response :success
  end

  test "should get edit" do
    get reportes_edit_url
    assert_response :success
  end

  test "should get show" do
    get reportes_show_url
    assert_response :success
  end
end
