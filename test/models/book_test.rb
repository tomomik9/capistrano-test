require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    @book = books(:book1)
  end  

  # Validation Test
  should validate_presence_of :title
  should validate_presence_of :memo

  # Polymorphic Association
  test 'book comments' do
    assert_equal 1, @book.comments.size
  end

  # Registration Test
  test "the book registration" do
    assert_difference 'Book.count', 1 do
      Book.create(title: @book.title,  memo: @book.memo, author: @book.author, picture: @book.picture)
    end
  end
end
