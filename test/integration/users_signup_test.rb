require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:thierry)
  end
  
  test "invalid signup information shouldn't add a new user" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {  email: "",
                                password: "lol",
                                password_confirmation: "rofl" }
    end
  end
  
  test "valid signup information should add a new user" do
    get signup_path
    assert_difference 'User.count' do
      post_via_redirect users_path, user: { email: "cool@cool.com",
                                password: "password",
                                password_confirmation: "password" }
    end
  assert_template 'entries/index'
  
  end
  
end