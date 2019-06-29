require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report = reports(:report1)
  end

  test 'report must be valid' do
    assert @report.valid?
  end
  
  # Association
  test '#comments' do
    assert_equal 1, @report.comments.size
  end
end
