require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "signs in with valid password" do
    sign_in!
  end

  test "signs in with invalid password" do
    post sessions_path, params: { password: "pass" }

    assert_response :unprocessable_entity
  end

  test "authenticated signs out" do
    sign_in!
    sign_out!
  end

  test "unauthenticated signs out" do
    sign_out!
  end
end
