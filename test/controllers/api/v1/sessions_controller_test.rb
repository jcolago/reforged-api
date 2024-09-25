require "test_helper"
# The below code is a test suite for the Api::SessionsController in a Ruby on Rails application.
# It includes tests for logging in with valid and invalid credentials, retrieving the current user,
# and logging out. The tests use the ActionDispatch::IntegrationTest framework to simulate HTTP requests
# and assert the expected responses. The setup method initializes a user fixture for use in the tests.
# The tests check for successful responses, the presence of a JWT token, and the correctness of error messages.
# Overall, this test suite ensures that the session management functionality of the API works as intended.
# It verifies that users can log in, retrieve their information, and log out correctly.
# The tests also ensure that appropriate error messages are returned for invalid login attempts.
# This helps maintain the reliability and security of the authentication system in the application.
# The use of fixtures allows for consistent and repeatable tests, making it easier to identify issues
class Api::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end
  test "login with valid credentials" do
    post api_login_url, params: { email: @user.email, password: "password123" }
    assert_response :success
    assert_not_nil response.parsed_body["token"]
  end
  test "login with invalid credentials" do
    post api_login_url, params: { email: @user.email, password: "wrong_password" }
    assert_response :unauthorized
    assert_equal "Invalid email address or password.", response.parsed_body["error"]
  end
  test "me returns current user" do
    post api_login_url, params: { email: @user.email, password: "password123" }
    token = response.parsed_body["token"]
    get api_me_url, headers: { Authorization: "Bearer #{token}" }
    assert_response :success
    assert_equal @user.id, response.parsed_body["user"]["id"]
  end
  test "logout" do
    post api_login_url, params: { email: @user.email, password: "password123" }
    token = response.parsed_body["token"]
    delete api_logout_url, headers: { Authorization: "Bearer #{token}" }
    assert_response :success
    assert_equal "Logged out successfully.", response.parsed_body["message"]
  end
end
