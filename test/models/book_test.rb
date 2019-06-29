require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  setup do
    @book = books(:book1)
  end  

  # Validation Tests
  should validate_presence_of :title
  should validate_presence_of :memo

  # Association
  test '#comments' do
    assert_equal 1, @book.comments.size
  end
end
