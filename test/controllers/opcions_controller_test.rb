require "test_helper"

class OpcionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get opcions_index_url
    assert_response :success
  end

  test "should get new" do
    get opcions_new_url
    assert_response :success
  end

  test "should get show" do
    get opcions_show_url
    assert_response :success
  end

  test "should get edit" do
    get opcions_edit_url
    assert_response :success
  end
end
