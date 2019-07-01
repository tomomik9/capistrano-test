require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Validation Test
  should validate_presence_of :password
  should validate_presence_of :email
  should validate_uniqueness_of :email
 
  # OmniAuth Authentication Test
  setup do 
    @github_params1 = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '123545',
      :info => {
        :name => 'test',
        :email => 'test@gmail.com',
        :avatar_url => 'https://avatars3.githubusercontent.com/u/1...'
      },
      :password => Devise.friendly_token[0, 20]
    })
  end

  test "should find and authenticate an user from GitHub callback parameters" do
    @user = User.find_for_github_oauth(@github_params1)
    assert_equal User.where(uid: "123545", provider: "github").first, @user
  end  

  test "should create an user from GitHub callback parameters" do
    assert_nil(User.where(uid: "100", provider: "github").first)
     @github_params2 = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '100',
      :info => {
        :name => 'test2',
        :email => 'test2@gmail.com',
        :avatar_url => 'https://avatars3.githubusercontent.com/u/2...'
      },
      :password => Devise.friendly_token[0, 20]
    })
    @user2 = User.find_for_github_oauth(@github_params2)
    assert_equal User.count, 4
    assert_equal User.where(uid: "100", provider: "github").first, @user2
    assert_equal User.where(uid: "100", provider: "github").first.email, @user2.email
  end

  # Follow Test
  test "should follow and unfollow a user" do
    @user1 = users(:keith)
    @user2  = users(:layla)
    assert_not @user1.following?(@user2)
    @user1.follow(@user2)
    assert @user1.following?(@user2)
    @user1.unfollow(@user2)
    assert_not @user1.following?(@user2)
  end

  test "user registrations and file upload" do
    upload_file = Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/blue.jpg'))
    assert_difference 'User.count', 1 do
      User.create(username: "Lily",
        email: "lily@gmail.com",
        address: "unknown",
        password: "Fxjifiv", image: upload_file, bio: "Hi!", postal_code: "111-1000" ).save!
    end
  end
end
