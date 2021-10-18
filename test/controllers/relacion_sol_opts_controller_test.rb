require "test_helper"

class RelacionSolOptsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relacion_sol_opts_index_url
    assert_response :success
  end

  test "should get new" do
    get relacion_sol_opts_new_url
    assert_response :success
  end

  test "should get show" do
    get relacion_sol_opts_show_url
    assert_response :success
  end
end
