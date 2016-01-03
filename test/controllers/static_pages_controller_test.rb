require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Better Days"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | Better Days"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | Better Days"
  end

end
