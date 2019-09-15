require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example name", email: "example@email.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "validates username" do
    @user.name = "    "

    assert_not @user.valid?
  end

  test "validates email" do
    @user.email = "    "

    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "validation should accept valid email addresses" do
    valid_emails = %w[user@example.com USER@foo.com A_US-EU@foo.bar.org first.last@boo.jp alice+bob@woo.cn]

    valid_emails.each do |email|
      @user.email = email
      assert @user.valid? , "address #{email.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_emails = %w[user@example,com user_foo_at_foo.org user.name@example. foo@bar_baz.com foo@bar+boo.com]

    invalid_emails.each do |email|
      @user.email = email

      assert_not @user.valid? , "address #{email.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save

    assert_not duplicate_user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end


end
