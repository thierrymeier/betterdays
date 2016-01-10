require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:thierry)
    @other_user = users(:steve)
    ActionMailer::Base.deliveries.clear
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
  
  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name:  "Example User",
                               email: "user@example.com",
                               password:              "password",
                               password_confirmation: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template root_path
    assert is_logged_in?
  end
end