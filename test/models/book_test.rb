require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    @book = books(:book1)
  end

  test 'user must be valid' do
    assert @book.valid?
  end

  test 'must have title' do
    @book.title = nil
    assert @book.invalid?
    assert_includes @book.errors[:title], "を入力してください"
  end
end
