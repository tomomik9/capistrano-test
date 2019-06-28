require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:keith)
  end

  test 'user must be valid' do
    assert @user.valid?
  end

  test 'must have email address' do
    @user.email = nil
    assert @user.invalid?
    assert_includes @user.errors[:email], "を入力してください"
  end
end
