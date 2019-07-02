require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers
  def setup
    @user = users(:keith)
    @report = reports(:report1)
  end
  
  test "show listing reports" do
    login_as(@user)
    visit "/reports"
    assert_selector "h1", text: "日報一覧"
  end

  test "register a report" do
    login_as(@user)
    visit new_report_path
    fill_in "日報タイトル", with: @report.title,  match: :first
    fill_in "内容", with: @report.memo
    click_button "登録する"
    assert_text "無事登録されました"
  end

  test "update a report" do
    login_as(@user)
    visit "/reports/#{@report.id}/edit"
    fill_in "日報タイトル", with: "本日の学習",  match: :first
    fill_in "内容", with: "httpの学習"
    click_button "更新する"
    assert_text "無事更新されました"
  end

  test "destroy a report" do
    login_as(@user)
    visit reports_url
    page.accept_confirm do
      click_link "削除", match: :first
    end
    assert_text "無事削除されました"
  end
end
