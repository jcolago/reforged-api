require "test_helper"

class Api::V1::ConditionsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  setup do
    setup_test_data
    @auth_token = login_user(@user)
  end

  test "should get index" do
    get api_v1_conditions_url, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    conditions = JSON.parse(response.body)
    assert_equal Condition.count, conditions.length
  end

  test "should show condition" do
    get api_v1_condition_url(@condition), headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    condition_response = JSON.parse(response.body)
    assert_equal @condition.name, condition_response["name"]
  end

  test "should create condition" do
    assert_difference("Condition.count") do
      post api_v1_conditions_url, params: { condition: @condition_params }, headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :created
    new_condition = JSON.parse(response.body)
    assert_equal @condition_params[:name], new_condition["name"]
  end

  test "should not create condition with invalid params" do
    assert_no_difference("Condition.count") do
      post api_v1_conditions_url, params: { condition: { name: "" } }, headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :unprocessable_entity
  end

  test "should update condition" do
    patch api_v1_condition_url(@condition), params: { condition: { name: "Updated Condition" } }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    @condition.reload
    assert_equal "Updated Condition", @condition.name
  end

  test "should not update condition with invalid params" do
    patch api_v1_condition_url(@condition), params: { condition: { name: "" } }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :unprocessable_entity
  end

  test "should destroy condition" do
    assert_difference("Condition.count", -1) do
      delete api_v1_condition_url(@other_condition), headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :no_content
  end
end
