require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user       = users(:thierry)
    @other_user = users(:steve)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get edit" do
    log_in_as(@user)
    get :edit, id: @user
    assert_response :success
  end

  test "should not get edit of another user" do
    log_in_as(@user)
    get :edit, id: @other_user
    assert_redirected_to root_url
  end
  
  test "should not update when logged in as wrong user" do
    log_in_as(@user)
    patch :update, id: @other_user, user: { email: @other_user.email, password: "password", password_confirmation: "password" }
    assert_redirected_to root_url
  end

end
