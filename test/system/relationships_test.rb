require "application_system_test_case"

class RelationshipsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers
  def setup
    @user  = users(:keith)
    @other = users(:layla)
  end
   
  test "following a user" do
    login_as(@user)
    visit "users/#{@other.id}"
    click_on "フォローする"
    assert_text "フォローしました"
  end

  test "unfollowing a user" do
    login_as(@user)
    @user.following << @other
    visit "users/#{@other.id}"
    click_on "フォロー解除"
    assert_text "フォロー解除しました"
  end
end
