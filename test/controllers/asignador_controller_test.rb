require "test_helper"

class AsignadorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get asignador_index_url
    assert_response :success
  end

  test "should get show" do
    get asignador_show_url
    assert_response :success
  end
end
