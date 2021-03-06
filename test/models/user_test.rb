require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: "Thierry", email: "testuser@example.com", password: "foobar", password_confirmation: "foobar")
  end
  
  test "user should be valid" do
    assert @user.valid?
  end
  
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  
  test "password should be present" do
    @user.password = " "
    assert_not @user.valid?
  end
  
  test "password should be longer than 6 characters" do
    @user.password = "foo"
    @user.password_confirmation = "foo"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "posts by destroyed user must be destroyed too" do
    @user.save
    @user.entries.create!(content: "Lorem" * 50)
    assert_difference 'Entry.count', -1 do
      @user.destroy
    end
  end
end
