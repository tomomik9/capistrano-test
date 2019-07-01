require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @comment1 = comments(:one)
    @comment2 = comments(:two)
  end
  
  # Validation Test
  should validate_presence_of :title
  should validate_presence_of :body

  # Polymorphic Association 
  test 'comment1 on reports' do
    assert_equal 'Report', @comment1.commentable_type
  end

  test 'comment2 on books' do
    assert_equal 'Book', @comment2.commentable_type
  end
end
