require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  
  def setup
    @entry        = entries(:one)
    @other_entry  = entries(:two)
    @user        = users(:thierry)
    @other_user   = users(:steve)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Entry.count' do
      post :create, entry: { content: "Lorem Ipsum" * 50 }
    end
    assert_redirected_to login_path
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Entry.count' do
      delete :destroy, id: @entry
    end
    assert_redirected_to login_path
  end
  
  test "should redirect destroy for wrong entry" do
    log_in_as(users(:thierry))
    entry = entries(:two)
    assert_no_difference 'Entry.count' do
      delete :destroy, id: entry
    end
    assert_redirected_to root_path
  end
  
  test "should redirect show action on entry that does not belong to you" do
    log_in_as(@user)
    get :show, id: @other_entry
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
  test "should redirect create action on entry with id that doesn't belong to you" do
    log_in_as(@user)
    assert_no_difference 'Entry.count' do
      post :create, entry: { content: "Lorem Ipsum" * 50, id: @other_user }
    end
  end
end
