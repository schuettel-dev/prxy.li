require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get links_index_url
    assert_response :success
  end

  test "should get new" do
    get links_new_url
    assert_response :success
  end

  test "should get create" do
    get links_create_url
    assert_response :success
  end

  test "should get destroy" do
    get links_destroy_url
    assert_response :success
  end
end
