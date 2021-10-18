require "test_helper"

class OpcionAvanzadasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get opcion_avanzadas_index_url
    assert_response :success
  end
end
