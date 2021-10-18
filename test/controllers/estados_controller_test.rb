require "test_helper"

class EstadosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get estados_index_url
    assert_response :success
  end

  test "should get new" do
    get estados_new_url
    assert_response :success
  end
end
