require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "Game is valid" do
    games = games(:game_one)
    assert games.valid?
  end

  test "invalid without name" do
    games = games(:game_one)
    games.name = nil
    assert_not games.valid?
    assert_includes games.errors[:name], "can't be blank"
  end

  test "invalid without dm" do
    games = games(:game_one)
    games.dm = nil
    assert_not games.valid?
    assert_includes games.errors[:dm], "must exist"
  end
end
