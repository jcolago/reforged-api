require "test_helper"

class ConditionTest < ActiveSupport::TestCase
  test "valid condititon" do
    conditions = conditions(:poisoned)
    assert conditions.valid?
  end

  test "invalid without name" do
    conditions = conditions(:poisoned)
    conditions.name = nil
    assert_not conditions.valid?
    assert_includes conditions.errors[:name], "can't be blank"
  end
end
