require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = users(:dm)
    assert user.valid?, "User should be valid. Errors: #{user.errors.full_messages}"
  end

  test "invalid without email" do
    user = users(:dm)
    user.email = nil
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "invalid with duplicate email" do
    existing_user = users(:dm)
    new_user = User.new(email: existing_user.email, password: "password")
    assert_not new_user.valid?
    assert_includes new_user.errors[:email], "has already been taken"
  end

  test "invalid with short password" do
    user = User.new(email: "new@example.com", password: "short")
    assert_not user.valid?
    assert_includes user.errors[:password], "is too short (minimum is 6 characters)"
  end
end
