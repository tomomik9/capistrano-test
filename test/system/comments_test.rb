require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers
  def setup
    @user = users(:keith)
    @comment = comments(:one)
  end

  test "show listing comments" do
    login_as(@user)
    visit "/reports/#{@comment.commentable_id}/comments"
    assert_selector "h1", text: "コメント一覧"
  end

  test "create a comment" do
    login_as(@user)
    visit "/reports/#{@comment.commentable_id}/comments"
    click_link "新規コメント登録"
    fill_in "コメント題名", with: "本1"
    fill_in "コメント", with: "メモです。"
    click_button "登録する"
    assert_text "無事登録されました"
  end

  test "update a comment" do
    login_as(@user)
    visit "/reports/#{@comment.commentable_id}/comments/#{@comment.id}/edit"
    fill_in "コメント題名", with: "本2",  match: :first
    fill_in "コメント", with: "ジャンルはコメディ"
    click_button "更新する"
    assert_text "無事更新されました"
  end

  test "destroy a comment" do
    login_as(@user)
    visit "/reports/#{@comment.commentable_id}/comments"
    page.accept_confirm do
      click_link "削除", match: :first
    end
    assert_text "無事削除されました"
  end
end
