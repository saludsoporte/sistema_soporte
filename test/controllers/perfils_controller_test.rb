require "test_helper"

class PerfilsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get perfils_index_url
    assert_response :success
  end

  test "should get show" do
    get perfils_show_url
    assert_response :success
  end
end
