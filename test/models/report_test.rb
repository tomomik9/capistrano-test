require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report = reports(:report1)
  end

  # Validation Test
  should validate_presence_of :title
  should validate_presence_of :memo

  # Polymorphic Association
  test 'comments on reports' do
    assert_equal 1, @report.comments.size
  end

  # Report Tests
  test "the report" do
    assert_difference 'Report.count', 1 do
      Report.create(title: @report.title, memo: @report.memo)
    end
  end
end
