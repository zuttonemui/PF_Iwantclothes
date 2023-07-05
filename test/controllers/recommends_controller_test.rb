require "test_helper"

class RecommendsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recommends_index_url
    assert_response :success
  end

  test "should get new" do
    get recommends_new_url
    assert_response :success
  end

  test "should get edit" do
    get recommends_edit_url
    assert_response :success
  end
end
