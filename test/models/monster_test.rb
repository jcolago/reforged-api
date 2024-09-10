require "test_helper"

class MonsterTest < ActiveSupport::TestCase
  test "valid monster" do
    monster = monsters(:one)
    assert monster.valid?, "Monster should be valid. Errors: #{monster.errors.full_messages}"
  end

  test "invalid without name" do
    monster = monsters(:one)
    monster.name = nil
    assert_not monster.valid?
    assert_includes monster.errors[:name], "can't be blank"
  end

  test "invalid with non-integer values" do
    monster = monsters(:one)
    int_attributes = [ :armor_class, :hit_points, :speed, :p_bonus ]
    int_attributes.each do |attr|
      monster[attr] = "not an integer"
      assert_not monster.valid?
      assert_includes monster.errors[attr], "is not a number"
      monster.reload
    end
  end

  test "displayed must be boolean" do
    monster = monsters(:one)

    monster.displayed = nil
    assert_not monster.valid?
    assert_includes monster.errors[:displayed], "is not included in the list"

    monster.displayed = true
    assert monster.valid?, "Monster should be valid with displayed = true. Errors: #{monster.errors.full_messages}"

    monster.displayed = false
    assert monster.valid?, "Monster should be valid with displayed = false. Errors: #{monster.errors.full_messages}"
  end
end
