require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:redvan)
    
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)  
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be preset" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be preset" do
    @micropost.content = "    "
    assert_not @micropost.valid?
  end

  test "content should be 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end
end
