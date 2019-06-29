require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Validation Test
  should validate_presence_of :password
  should validate_presence_of :email
  should validate_uniqueness_of :email
 
  # OmniAuth Authentication Test
  setup do
    @user = User.new({
      :provider => 'github',
      :uid => '123', 
      :username => 'test',
      :password => Devise.friendly_token[0, 20]
     } )
  end

  test 'authenticate an user' do
    @user1 = User.where(provider: "github", uid: "123").first
    assert_equal "test", @user1.username
  end

  setup do
    @user = OmniAuth::AuthHash.new({
    :provider => 'github',
    :uid => '123545',
    :username => 'test2', 
    :avatar_url => 'nnnnnnnnnnnn', 
    :password => Devise.friendly_token[0, 20]
})
  end

  test 'nyaonyao' do
    assert_equal 'test2', @user[:username]
  end
end
