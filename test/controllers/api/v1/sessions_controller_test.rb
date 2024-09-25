require "test_helper"

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user.update(password: 'password123', password_confirmation: 'password123')
  end

  test "login with valid credentials" do
    post api_v1_login_url, params: { email: @user.email, password: "password123" }
    assert_response :success
    assert_not_nil response.parsed_body["token"]
  end

  test "login with invalid credentials" do
    post api_v1_login_url, params: { email: @user.email, password: "wrong_password" }
    assert_response :unauthorized
    assert_equal "Invalid email address or password.", response.parsed_body["error"]
  end

  test "me returns current user" do
    post api_v1_login_url, params: { email: @user.email, password: "password123" }
    token = response.parsed_body["token"]
    get api_v1_me_url, headers: { Authorization: "Bearer #{token}" }
    assert_response :success
    assert_equal @user.id, response.parsed_body["user"]["id"]
  end

  test "logout" do
    post api_v1_login_url, params: { email: @user.email, password: "password123" }
    token = response.parsed_body["token"]
    delete api_v1_logout_url, headers: { Authorization: "Bearer #{token}" }
    assert_response :success
    assert_equal "Logged out successfully.", response.parsed_body["message"]
  end
end