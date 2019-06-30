require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Warden::Test::Helpers
  def setup
    @user = users(:keith)
  end

  test "show listing users" do
    login_as(@user)
    visit "/users"
    assert_selector "h1", text: "ユーザー一覧"
  end

  test "register an user" do
    visit users_url
    click_on "アカウント登録"
    fill_in "ユーザー名", with: "John Doe",  match: :first
    fill_in "Eメール", with: "john@gmail.com"
    fill_in "郵便番号", with: "130-0000"
    fill_in "住所", with: "unknown"
    fill_in "自己紹介", with: "Hi"
    fill_in "パスワード", with: "99990000"
    fill_in "パスワード（確認用）", with: "99990000"
    click_button "アカウント登録"
    assert_text "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
  end

  test "update an user" do
    login_as(@user)
    visit users_url
    click_on "プロフィール編集"
    fill_in "Eメール", with: "keith@gmail.com",  match: :first
    fill_in "パスワード", with: "99991111"
    fill_in "パスワード（確認用）", with: "99991111"
    fill_in "現在のパスワード", with: "password"
    click_button "更新"
    assert_text "アカウント情報を変更しました。"
  end

  test "destroy an user record" do
    login_as(@user)
    visit users_url
    click_on "プロフィール編集"
    page.accept_confirm do
      click_button "アカウント削除", match: :first
    end
    assert_text "アカウントを削除しました。またのご利用をお待ちしております。"
  end

  test "#logout" do
    login_as(@user)
    visit reports_path
    click_on "ログアウト"
    assert_text "ログアウトしました"
  end
end
