require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @comment = comments(:one)
  end

  test 'report must be valid' do
    assert @comment.valid?
  end

  test 'must have title' do
    @comment.title = nil
    assert @comment.invalid?
    assert_includes @comment.errors[:title], "を入力してください"
  end
end
