require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:thierry)
    @other_user = users(:steve)
  end
  
  test "invalid signup information shouldn't add a new user" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {  email: "",
                                password: "lol",
                                password_confirmation: "rofl" }
    end
    assert_template 'users/new'
  end
  
  test "valid signup information should add a new user" do
    get signup_path
    assert_difference 'User.count', 1, 'User should be created' do
      post  users_path, user: { email: "megatoll@cool.com",
                                password: "password",
                                password_confirmation: "password" }
    end
    assert_redirected_to root_path
  end
end