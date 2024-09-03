require "test_helper"

class Api::V1::GamesControllerTest < ActionDispatch::IntegrationTest
  test "getting all the games works" do
    get api_v1_games_url
    assert_response :success
  end

  test "creating a new game works" do
    user = users(:dm)
    post api_v1_games_url,
         params: {
          game: {
            name: "Some Game",
            dm_id: user.id
          }
         }
    assert_response :success
    new_game = JSON.parse(response.body)
    assert_equal "Some Game", new_game["name"]
  end
end
