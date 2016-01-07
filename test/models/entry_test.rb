require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:thierry)
    @entry = @user.entries.build(content: "Lorem" * 50)
  end
  
  test "should be valid" do
    assert @entry.valid?
  end
  
  test "user id should be present" do
    @entry.user_id = nil
    assert_not @entry.valid?
  end
  
  test "content should be present" do
    @entry.content = "   "
    assert_not @entry.valid?
  end
  
  test "content should be longer than" do
    @entry.content = "Lorem"
    assert_not @entry.valid?
  end
  
  test "order should be most recent first" do
    assert_equal entries(:most_recent), Entry.first
  end
  
end
