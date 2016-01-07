require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:thierry)
  end
  
  test "login with invalid login information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: " ", password: " " }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
  end
  
  test "login with valid login information" do
    get login_path
    assert_template 'sessions/new'
    post_via_redirect sessions_path, email: @user.email, password: "foobar"
    assert_template 'entries/index'
    assert_select "a[href=?]", logout_path
  end
  
end