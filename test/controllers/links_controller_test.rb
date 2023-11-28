require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_in!
    get links_path

    assert_response :success
  end

  test "should get new" do
    sign_in!
    get new_link_path

    assert_response :success
  end

  test "should post create" do
    sign_in!

    assert_difference -> { Link.count }, +1 do
      post links_path, params: {
        link: {
          target: "https://example.com",
          never_expire: "0"
        }
      }
    end

    follow_redirect!

    assert_response :success
  end

  test "should get destroy" do
    link = links(:rubymonstas)

    sign_in!
    assert_difference -> { Link.count }, -1 do
      delete link_path(link)
    end

    follow_redirect!

    assert_response :success
  end
end
