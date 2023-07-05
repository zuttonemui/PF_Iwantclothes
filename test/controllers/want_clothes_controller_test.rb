require "test_helper"

class WantClothesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get want_clothes_index_url
    assert_response :success
  end

  test "should get new" do
    get want_clothes_new_url
    assert_response :success
  end

  test "should get edit" do
    get want_clothes_edit_url
    assert_response :success
  end
end
