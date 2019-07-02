require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  include Warden::Test::Helpers
  def setup
    @user = users(:keith)
    @book = books(:book1)
  end

  test "show listing books" do
    login_as(@user)
    visit "/books"
    assert_selector "h1", text: "書籍一覧"
  end

  test "register a book" do
    login_as(@user)
    visit new_book_path
    fill_in "タイトル", with: @book.title, match: :first
    fill_in "メモ", with: @book.memo
    fill_in "著者", with: @book.author
    attach_file("画像", "test/fixtures/files/Ruby.jpg")
    click_button "登録する"
    assert_text "無事登録されました"
  end

  test "update a book info" do
    login_as(@user)
    visit "/books/#{@book.id}/edit"
    fill_in "タイトル", with: "本2",  match: :first
    fill_in "メモ", with: "ジャンルはコメディ"
    fill_in "著者", with: "猫"
    click_button "更新する"
    assert_text "無事更新されました"
  end

  test "destroy a book info" do
    login_as(@user)
    visit books_url
    page.accept_confirm do
      click_link "削除", match: :first
    end
    assert_text "無事削除されました"
  end
end
