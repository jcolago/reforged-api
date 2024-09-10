require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:dm)
    @user_params = {
      email: "newuser@example.com",
      password: "password123",
      password_confirmation: "password123"
    }
  end

  test "should get index" do
    get api_v1_users_url
    assert_response :success
    users = JSON.parse(response.body)
    assert_equal User.count, users.length
    assert_not users.first.key?("password_digest"), "Password digest should not be included in response"
  end

  test "should show user" do
    get api_v1_user_url(@user)
    assert_response :success
    user_response = JSON.parse(response.body)
    assert_equal @user.email, user_response["email"]
    assert_not user_response.key?("password_digest"), "Password digest should not be included in response"
  end

  test "should create user" do
    assert_difference("User.count") do
      post api_v1_users_url, params: { user: @user_params }
    end

    assert_response :created
    new_user = JSON.parse(response.body)
    assert_equal @user_params[:email], new_user["email"]
    assert_not new_user.key?("password_digest"), "Password digest should not be included in response"
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post api_v1_users_url, params: { user: @user_params.merge(email: "") }
    end

    assert_response :unprocessable_entity
  end

  test "should update user" do
    patch api_v1_user_url(@user), params: { user: { email: "updated@example.com" } }
    assert_response :success
    @user.reload
    assert_equal "updated@example.com", @user.email
  end

  test "should not update user with invalid params" do
    patch api_v1_user_url(@user), params: { user: { email: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete api_v1_user_url(@user)
    end

    assert_response :no_content
  end
end
