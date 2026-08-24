# test/models/user_test.rb
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "is valid" do
    assert users(:alice).valid?
  end

  test "rejects a duplicate email" do
    user =
      User.new(
        email_address: users(:alice).email_address,
        password: "password",
        password_confirmation: "password"
      )

    assert_not user.valid?
    assert_includes user.errors[:email_address], "has already been taken"
  end

  test "rejects a blank email" do
    user =
      User.new(
        email_address: "",
        password: "password",
        password_confirmation: "password"
      )

    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "rejects a password confirmation mismatch" do
    user =
      User.new(
        email_address: "newcook@example.com",
        password: "password",
        password_confirmation: "different"
      )

    assert_not user.valid?
    assert_includes user.errors[:password_confirmation],
                    "doesn't match Password"
  end
end
