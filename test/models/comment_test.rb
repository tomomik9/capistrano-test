require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @comment1 = comments(:one)
    @comment2 = comments(:two)
  end
  
  # Validation Tests
  should validate_presence_of :title
  should validate_presence_of :body

  # Polymorphic Association 
  test 'comment1' do
    assert_equal 'Report', @comment1.commentable_type
  end

  test 'comment2' do
    assert_equal 'Book', @comment2.commentable_type
  end
end
