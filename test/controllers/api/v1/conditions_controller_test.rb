require "test_helper"

class Api::V1::ConditionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @condition = conditions(:poisoned)
    @other_condition = conditions(:superhero)
    @condition_params = { name: "New Condition" }
  end

  test "should get index" do
    get api_v1_conditions_url
    assert_response :success
    conditions = JSON.parse(response.body)
    assert_equal Condition.count, conditions.length
  end

  test "should show condition" do
    get api_v1_condition_url(@condition)
    assert_response :success
    condition_response = JSON.parse(response.body)
    assert_equal @condition.name, condition_response["name"]
  end

  test "should create condition" do
    assert_difference("Condition.count") do
      post api_v1_conditions_url, params: { condition: @condition_params }
    end

    assert_response :created
    new_condition = JSON.parse(response.body)
    assert_equal @condition_params[:name], new_condition["name"]
  end

  test "should not create condition with invalid params" do
    assert_no_difference("Condition.count") do
      post api_v1_conditions_url, params: { condition: { name: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "should update condition" do
    patch api_v1_condition_url(@condition), params: { condition: { name: "Updated Condition" } }
    assert_response :success
    @condition.reload
    assert_equal "Updated Condition", @condition.name
  end

  test "should not update condition with invalid params" do
    patch api_v1_condition_url(@condition), params: { condition: { name: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy condition" do
    assert_difference("Condition.count", -1) do
      delete api_v1_condition_url(@other_condition)
    end

    assert_response :no_content
  end
end
