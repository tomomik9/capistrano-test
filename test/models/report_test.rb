require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report = reports(:report1)
  end

  test 'report must be valid' do
    assert @report.valid?
  end

  test 'must have title' do
    @report.title = nil
    assert @report.invalid?
    assert_includes @report.errors[:title], "を入力してください"
  end
end
