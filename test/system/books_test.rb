require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
include Warden::Test::Helpers
 
  def setup
    @user = users(:keith)
    @book = books(:book1)
  end

  test "creating a book record" do
    login_as(@user)
    visit new_book_path
    fill_in "タイトル", with: @book.title, match: :first
    fill_in "メモ", with: @book.memo
    fill_in "著者", with: @book.author
    click_button "登録する"
    assert_text "無事登録されました"
  end

  test "updating a book record" do
    login_as(@user)
    visit "/books/#{@book.id}/edit"
    fill_in "タイトル", with: "本2",  match: :first
    fill_in "メモ", with: "ジャンルはコメディ"
    fill_in "著者", with: "猫"
    click_button "更新する"
    assert_text "無事更新されました"
  end

  test "destroying a book record" do
    login_as(@user)
    visit books_url
    page.accept_confirm do
      click_link "削除", match: :first
    end
    assert_text "無事削除されました"
  end
end
