# test/support/test_setup_helper.rb

module TestSetupHelper
  def setup_test_data
    @game = games(:game_one)
    @other_game = games(:game_two)
    @user = users(:dm)
    @other_user = users(:other_dm)
    @player = players(:joe)
    @monster = monsters(:one)
    @condition = conditions(:poisoned)
    @player_condition = player_conditions(:one)

    @game_params = { name: "New Game", dm_id: @user.id }
    @player_params = {
      name: "New Player",
      character: "New Character",
      image: "new-url-here",
      level: 2,
      current_hp: 15,
      total_hp: 20,
      armor_class: 16,
      speed: 30,
      initiative_bonus: 2,
      strength: 14,
      dexterity: 13,
      constitution: 15,
      intelligence: 12,
      wisdom: 10,
      charisma: 11,
      displayed: true,
      game_id: @game.id
    }
    @monster_params = {
      name: "New Monster",
      size: :medium,
      alignment: :neutral_good,
      armor_class: 15,
      hit_points: 30,
      speed: 25,
      resistances: "Fire,Ice",
      p_bonus: 3,
      attacks: "Bite,Scratch",
      displayed: true,
      game_id: @game.id
    }
    @condition_params = { name: "New Condition" }
    @player_condition_params = {
      condition_length: 2,
      player_id: @player.id,
      condition_id: @condition.id
    }
    @user_params = {
      email: "newuser@example.com",
      password: "password123",
      password_confirmation: "password123"
    }
  end

  def login_user(user)
    post api_v1_login_url, params: { email: user.email, password: 'password123' }
    JSON.parse(response.body)['token']
  end
end