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
  
  # Edit

  test "redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  # Update
  
  test "redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { email: @user.email, password: "password", password_confirmation: "password" }
    assert flash.empty?
    assert_redirected_to root_url
  end

end
