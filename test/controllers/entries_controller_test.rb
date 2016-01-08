require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  
  def setup
    @entry        = entries(:one)
    @other_entry  = entries(:two)
    @entry2       = entries(:three)
    @other_entry2 = entries(:four)
    @user         = users(:thierry)
    @other_user   = users(:steve)
  end
  
  # Show
  
  test "should redirect show when not logged in" do
    get :show, id: @entry
    assert_redirected_to login_path
  end
  
  test "should redirect show action on entry that does not belong to you" do
    log_in_as(@user)
    get :show, id: @other_entry
    assert_not flash.empty?
    assert_redirected_to root_path
  end
  
  test "should show entry that belongs to you" do
    log_in_as(@user)
    get :show, id: @entry
    assert_template 'entries/show'
  end
  
  # Create 

  test "should create entry with valid information" do
   log_in_as(@user)
    assert_difference 'Entry.count', 1, 'Entry should be created' do
      post :create, entry: { content: "Lorem Ipsum" * 50 }
    end
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Entry.count', 'No entry should have been created' do
      post :create, entry: { content: "Lorem Ipsum" * 50 }
    end
    assert_redirected_to login_path
  end
  
  #test "should redirect create action on entry with id that doesn't belong to you" do
   #log_in_as(@user)
    #assert_no_difference 'Entry.count', 'An entry should not be created' do
     #post :create, id: @other_user, entry: { content: "Lorem Ipsum"*10, id: @other_user }
    #end
  #end
  
  test "should not create entry with less than 50 characters" do
    log_in_as(@user)
    assert_no_difference 'Entry.count' do
      post :create, entry: { content: "Lorem Ipsum" }
    end
  end
  
  # Edit
  test "should edit entry that belongs to you" do
    log_in_as(@user)
    get :edit, id: @entry
    assert_template 'entries/edit'
  end
  
  test "should not be able to edit entries that don't belong to you" do
    log_in_as(@user)
    get :edit, id: @other_entry
    assert_redirected_to root_path
  end
  
  # Update
  test "should update entry that belongs to you" do
    log_in_as(@user)
    patch :update, id: @entry, entry: { content: "Lorem Ipsum"*50 }
    assert_redirected_to @entry
  end
  
  #test "should not update entry that doesn't belong to you" do
  # log_in_as(@other_user)
  #  patch :update, id: @entry, entry: { content: "lolerboat" * 50, id: @entry }
  #  assert_redirected_to root_path
  #end

  # Destroy
  
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
  
  test "should be able to destroy own entries" do
    log_in_as(@user)
    assert_difference 'Entry.count', -1, 'An Entry should be destroyed' do
      delete :destroy, id: @entry
    end
  end
end